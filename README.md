# Performance Measurement in Cloud Servers with TLS and VPN

## Overview  
This project evaluates the impact of encryption on the performance of cloud servers in **Google Cloud Platform (GCP)**.  
Two encryption approaches are compared: **TLS (Stunnel)** and **VPN (WireGuard)**.  
The study relies on **active and passive measurement techniques** to assess how these security mechanisms affect latency, throughput, jitter, CPU usage, and overall network load.

The experimental design applies **ANOVA-based statistical analysis** and includes multiple factors such as time of day, type of day (weekday vs. weekend), transmission rate (10 Mbps, 100 Mbps), and encryption configuration (none, TLS, VPN).  

---

## Key Objectives  

- Analyze the **performance impact** of TLS and WireGuard encryption on cloud-hosted servers.  
- Compare **delay, throughput, and jitter** under different configurations.  
- Evaluate the **resource consumption** (CPU, memory) introduced by encryption.  
- Assess **network load** using flow-based monitoring.  
- Provide an academic case study in **network performance evaluation**.  

---

## Methodology  

### Metrics  
- **Latency (Delay)** — measured with `hping3`  
- **Throughput & Jitter** — measured with `iperf3` (TCP/UDP)  
- **Network Load** — monitored with `netflow`, `sar`  
- **CPU/Memory Usage** — monitored with `vmstat`  

### Experimental Factors  
- **Encryption mode**: none, TLS (Stunnel), VPN (WireGuard)  
- **Time of day**: 08h, 15h, 19h, 22h  
- **Day type**: weekday, weekend  
- **Traffic rate**: 10 Mbps, 100 Mbps  

### Deployment  
- **Google Cloud Platform (GCP)**  
  - **Server**: Frankfurt (europe-west3)  
  - **Client**: Madrid (europe-southwest1)  
- **Ubuntu Server 22.04 LTS**  
- Services and measurements fully automated with **Bash scripts**.  

---

## Results (Summary)  

- **Latency**: No significant mean differences across configurations, but VPN introduced greater variability.  
- **Jitter**: Not significantly different across setups; slight increase under VPN.  
- **Throughput**: Strongly affected by transmission rate (10 vs. 100 Mbps), not by encryption.  
- **CPU Usage**: TLS and especially WireGuard increased CPU load significantly.  
- **Network Load**: Higher in encrypted scenarios, with WireGuard generating the most overhead.  

---

## Academic Relevance  

This project contributes to the study of:  
- **Real-time performance evaluation** in cloud environments.  
- **Impact of encryption** on network Quality of Service (QoS).  
- **Experimental design in networking** (multifactor ANOVA with replicates).  
- **Trade-offs between security and efficiency** in cloud infrastructures.  

---

## Future Work  

- Extend the comparison to other VPN protocols (e.g., OpenVPN, IPSec).  
- Explore **hybrid encryption approaches** and TLS optimizations.  
- Automate data visualization (e.g., dashboards for latency/jitter monitoring).  
- Evaluate **scalability** with multiple clients and servers.  
- Integrate **cost analysis** of overhead in cloud billing models.  

---

## License  

This research is shared for academic purposes. Reuse and citation are allowed with proper attribution.  

**Author**: Enrique Alcalá-Zamora Castro  
(MSc in Telecommunications Engineering, University of Granada) 
