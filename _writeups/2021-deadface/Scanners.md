---
# Obsidian
tags:
- ctf
- 2021-deadface
- traffic-analysis
- pcap
- go

# Jekyll
layout: ctf
type: problem

# Problem info
ctf: 2021-deadface
category: traffic-analysis
title: Scanners
points: 100
solved: true
---

# Scanners

## Instructions

Luciafer started the hack of the Lytton Labs victim by performing a port scan.

Which TCP ports are open on the victim's machine? Enter the flag as the open ports, separated by commas, no spaces, in numerical order. Disregard port numbers >= 16384.

Example: flag{80,110,111,143,443,2049}

Use the PCAP from **LYTTON LABS 01 - Monstrum ex Machina**.

## Solution

### Find the hosts
The first challenge is to identify the attacker IP and target for the port scan. I did this by determining the frequency of unique destination port hits per source and destination IP. We can safely ignore non-tcp packets and packets with destination ports > 16384 per the instructions. Our wireshark filter is also looking for tcp packets with only the SYN flag set so that we only have to look through the initial packets in the handshake.

```python
def identify_targets():
    filter = "tcp.flags eq 0x02 and tcp.dstport <= 16384"
    # SYN=1 and everything else 0
    cap = pyshark.FileCapture(pcap_file, keep_packets=False, display_filter=filter)

    unique_data_flows = {}
    for pkt in cap:
        dstport = int(pkt.tcp.dstport)
        key = f"{pkt.ip.src}->{pkt.ip.dst}"
        if key in unique_data_flows: 
            unique_data_flows[key].add(dstport)
        else:
            unique_data_flows[key] = {dstport}
    for k, v in unique_data_flows.items():
        print(f"{k}: {len(v)}")
```

The results of the analysis is that there is only one set of source and destination IPs with more than 2 unique destination ports:

```
192.168.100.106->192.168.100.103: 15779
```

Python performance for building the set of unique flows and destination ports was poor. I rewrote an implementation in Golang using gopacket and bpf instead of Python and pyshark.

```go
func findAttacker(pcapFile string) gopacket.Flow {
	var (
		handle *pcap.Handle
		err    error
	)

	// Open file instead of device
	handle, err = pcap.OpenOffline(pcapFile)
	if err != nil {
		log.Fatal(err)
	}
	defer handle.Close()

	// Set filter
	var filter string = "tcp[tcpflags] == 0x02 and tcp portrange 1-16384"
	err = handle.SetBPFFilter(filter)
	if err != nil {
		log.Fatal(err)
	}

	// Create storage for unique flows
	type EndpointSet map[gopacket.Endpoint]struct{}
	uniqueFlows := make(map[gopacket.Flow]EndpointSet)

	// Loop through packets
	packetSource := gopacket.NewPacketSource(handle, handle.LinkType())
	for packet := range packetSource.Packets() {
		var netFlow gopacket.Flow
		var dstPort gopacket.Endpoint

		// IP
		if net := packet.NetworkLayer(); net != nil {
			netFlow = net.NetworkFlow()
		}
		// TCP
		// We filtered to only tcp in transport in the bpf filters
		if tcp := packet.TransportLayer(); tcp != nil {
			dstPort = tcp.TransportFlow().Dst()
		}

		// Add flow if it doesn't exist
		if _, exists := uniqueFlows[netFlow]; !exists {
			uniqueFlows[netFlow] = make(EndpointSet)
		}

		// Add dst port to set if not already present
		if _, exists := uniqueFlows[netFlow][dstPort]; !exists {
			uniqueFlows[netFlow][dstPort] = struct{}{}
		}
	}

	// Print results and record flow with the largest # of unique dst ports
	var largestFlow gopacket.Flow
	var largestDstPorts int = 0
	for net, uniquePorts := range uniqueFlows {
		if len(uniquePorts) > largestDstPorts {
			largestFlow = net
			largestDstPorts = len(uniquePorts)
		}
	}

	fmt.Println(largestFlow)
	return largestFlow
}
```

This provided much improved performance. (~1 min in the Python version vs ~0.2 seconds in the Go implementation)

### Find the open ports
Now that we have the attacker and victim we can search for the valid responses from the port scan. We just need to filter for SYN ACK responses from the victim. The replies for the dst port of the attacker -> victim flow will originate from the same tcp src port on the victim -> attacker flow.   

```go
func findReplies(pcapFile string, flow gopacket.Flow) {
	var (
		handle *pcap.Handle
		err    error
	)

	// Open file instead of device
	handle, err = pcap.OpenOffline(pcapFile)
	if err != nil {
		log.Fatal(err)
	}
	defer handle.Close()

	// Set filter
	// tcpflags 0x12 is only SYN and ACK flags set
	filter := fmt.Sprintf("tcp[tcpflags] == 0x12 and tcp portrange 1-16384 and src host %v and dst host %v", flow.Dst(), flow.Src())
	err = handle.SetBPFFilter(filter)
	if err != nil {
		log.Fatal(err)
	}

	uniquePorts := make(map[gopacket.Endpoint]struct{})

	packetSource := gopacket.NewPacketSource(handle, handle.LinkType())
	for packet := range packetSource.Packets() {
		// TCP
		// We filtered to only tcp in transport in the bpf filters
		if tcp := packet.TransportLayer(); tcp != nil {
			uniquePorts[tcp.TransportFlow().Src()] = struct{}{}
		}
	}

	// Convert uniqueEndpoints from set to slice so we can sort it
	ports := make([]gopacket.Endpoint, 0, len(uniquePorts))
	for port, _ := range uniquePorts {
		ports = append(ports, port)
	}

	// Sort to ensure proper order
	sort.Slice(ports, func(i, j int) bool { return ports[i].LessThan(ports[j]) })

	// Print flag format
	fmt.Printf("Discovered ports: ")
	for index, port := range ports {
		fmt.Printf("%v", port)
		if index+1 != len(ports) {
			fmt.Printf(",")
		}
	}
	fmt.Println()
}
```

```
Discovered ports: 21,135,139,445,3389
```
## Continued On


