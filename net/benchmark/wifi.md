# 

## Baseline

Ran from macbook air while sitting in the threshold of the office. New router setup on the bench with macbook pro next to it.
Old router sitting on the office table.

```bash
❯ ./scripts/wifi-benchmark.sh 192.168.1.93

=== TCP Upload (client → server) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 57125 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec  34.6 MBytes   290 Mbits/sec    0   7.98 MBytes       
[  4]   1.00-2.00   sec  35.8 MBytes   300 Mbits/sec    0   7.98 MBytes       
[  4]   2.00-3.00   sec  35.0 MBytes   292 Mbits/sec    0   7.99 MBytes       
[  4]   3.00-4.00   sec  37.6 MBytes   317 Mbits/sec    0   7.99 MBytes       
[  4]   4.00-5.01   sec  35.2 MBytes   294 Mbits/sec    0   7.99 MBytes       
[  4]   5.01-6.00   sec  37.5 MBytes   316 Mbits/sec    0   7.99 MBytes       
[  4]   6.00-7.00   sec  38.4 MBytes   322 Mbits/sec    0   7.99 MBytes       
[  4]   7.00-8.00   sec  37.4 MBytes   312 Mbits/sec    0   7.99 MBytes       
[  4]   8.00-9.00   sec  21.9 MBytes   184 Mbits/sec    1   7.99 MBytes       
[  4]   9.00-10.01  sec  25.9 MBytes   216 Mbits/sec    1   7.99 MBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec   339 MBytes   284 Mbits/sec    2            sender
[  4]   0.00-10.11  sec   339 MBytes   282 Mbits/sec                  receiver

iperf Done.

=== TCP Download (server → client) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
Reverse mode, remote host 192.168.1.93 is sending
[  4] local 192.168.1.70 port 57131 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate
[  4]   0.00-1.01   sec  11.0 MBytes  91.8 Mbits/sec                  
[  4]   1.01-2.00   sec  12.4 MBytes   104 Mbits/sec                  
[  4]   2.00-3.00   sec  20.4 MBytes   171 Mbits/sec                  
[  4]   3.00-4.01   sec  22.9 MBytes   191 Mbits/sec                  
[  4]   4.01-5.01   sec  27.4 MBytes   230 Mbits/sec                  
[  4]   5.01-6.00   sec  40.5 MBytes   341 Mbits/sec                  
[  4]   6.00-7.00   sec  13.8 MBytes   116 Mbits/sec                  
[  4]   7.00-8.00   sec  23.6 MBytes   197 Mbits/sec                  
[  4]   8.00-9.01   sec  26.1 MBytes   219 Mbits/sec                  
[  4]   9.01-10.00  sec  25.9 MBytes   218 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.03  sec   228 MBytes   190 Mbits/sec    4            sender
[  4]   0.00-10.00  sec   224 MBytes   188 Mbits/sec                  receiver

iperf Done.

=== TCP Multi-stream (4 parallel) | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 57137 connected to 192.168.1.93 port 5201
[  6] local 192.168.1.70 port 57138 connected to 192.168.1.93 port 5201
[  8] local 192.168.1.70 port 57139 connected to 192.168.1.93 port 5201
[ 10] local 192.168.1.70 port 57140 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec  10.5 MBytes  87.7 Mbits/sec    0   4.98 MBytes       
[  6]   0.00-1.00   sec  7.38 MBytes  61.6 Mbits/sec    0   3.17 MBytes       
[  8]   0.00-1.00   sec  7.38 MBytes  61.6 Mbits/sec    0   2.47 MBytes       
[ 10]   0.00-1.00   sec  7.38 MBytes  61.6 Mbits/sec    1   2.63 MBytes       
[SUM]   0.00-1.00   sec  32.6 MBytes   272 Mbits/sec    1             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   1.00-2.00   sec  2.38 MBytes  19.9 Mbits/sec  728   2.78 MBytes       
[  6]   1.00-2.00   sec  4.00 MBytes  33.6 Mbits/sec   25    605 KBytes       
[  8]   1.00-2.00   sec  3.62 MBytes  30.4 Mbits/sec   22   1.34 MBytes       
[ 10]   1.00-2.00   sec  1.62 MBytes  13.6 Mbits/sec  358   1.41 KBytes       
[SUM]   1.00-2.00   sec  11.6 MBytes  97.5 Mbits/sec  1133             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   2.00-3.00   sec  3.00 MBytes  25.2 Mbits/sec    1    326 KBytes       
[  6]   2.00-3.00   sec  7.38 MBytes  61.9 Mbits/sec    1   1.60 MBytes       
[  8]   2.00-3.00   sec  10.2 MBytes  86.0 Mbits/sec    2   2.43 MBytes       
[ 10]   2.00-3.00   sec  9.50 MBytes  79.7 Mbits/sec  563   90.2 KBytes       
[SUM]   2.00-3.00   sec  30.1 MBytes   253 Mbits/sec  567             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    8   11.3 KBytes       
[  6]   3.00-4.00   sec  11.0 MBytes  92.6 Mbits/sec    0   1.61 MBytes       
[  8]   3.00-4.00   sec  17.0 MBytes   143 Mbits/sec    0   2.44 MBytes       
[ 10]   3.00-4.00   sec  9.50 MBytes  80.0 Mbits/sec    0   2.84 MBytes       
[SUM]   3.00-4.00   sec  37.5 MBytes   316 Mbits/sec    8             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec   62    233 KBytes       
[  6]   4.00-5.00   sec  8.12 MBytes  68.0 Mbits/sec    5   1.21 MBytes       
[  8]   4.00-5.00   sec  16.2 MBytes   136 Mbits/sec  224   1.74 MBytes       
[ 10]   4.00-5.00   sec  15.4 MBytes   129 Mbits/sec  486   2.08 MBytes       
[SUM]   4.00-5.00   sec  39.8 MBytes   333 Mbits/sec  777             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   5.00-6.01   sec   512 KBytes  4.19 Mbits/sec    0    276 KBytes       
[  6]   5.00-6.01   sec  9.00 MBytes  75.3 Mbits/sec    0   1.33 MBytes       
[  8]   5.00-6.01   sec  13.0 MBytes   109 Mbits/sec    0   1.91 MBytes       
[ 10]   5.00-6.01   sec  15.0 MBytes   126 Mbits/sec    0   2.20 MBytes       
[SUM]   5.00-6.01   sec  37.5 MBytes   314 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   6.01-7.01   sec  1.62 MBytes  13.6 Mbits/sec    0    301 KBytes       
[  6]   6.01-7.01   sec  8.38 MBytes  70.3 Mbits/sec    0   1.42 MBytes       
[  8]   6.01-7.01   sec  11.6 MBytes  97.5 Mbits/sec    0   2.05 MBytes       
[ 10]   6.01-7.01   sec  12.2 MBytes   103 Mbits/sec    0   2.27 MBytes       
[SUM]   6.01-7.01   sec  33.9 MBytes   284 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   7.01-8.00   sec  1.88 MBytes  15.8 Mbits/sec    0    317 KBytes       
[  6]   7.01-8.00   sec  9.75 MBytes  82.0 Mbits/sec    0   1.49 MBytes       
[  8]   7.01-8.00   sec  13.0 MBytes   109 Mbits/sec    0   2.17 MBytes       
[ 10]   7.01-8.00   sec  15.9 MBytes   134 Mbits/sec    0   2.35 MBytes       
[SUM]   7.01-8.00   sec  40.5 MBytes   341 Mbits/sec    0             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   8.00-9.00   sec  2.00 MBytes  16.7 Mbits/sec    5    240 KBytes       
[  6]   8.00-9.00   sec  9.38 MBytes  78.4 Mbits/sec  123   1.11 MBytes       
[  8]   8.00-9.00   sec  14.0 MBytes   117 Mbits/sec   12   1.61 MBytes       
[ 10]   8.00-9.00   sec  14.6 MBytes   122 Mbits/sec  599   1.71 MBytes       
[SUM]   8.00-9.00   sec  40.0 MBytes   335 Mbits/sec  739             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   9.00-10.01  sec  1.75 MBytes  14.7 Mbits/sec   89    187 KBytes       
[  6]   9.00-10.01  sec  8.50 MBytes  71.3 Mbits/sec    4    848 KBytes       
[  8]   9.00-10.01  sec  13.5 MBytes   113 Mbits/sec  140   1.20 MBytes       
[ 10]   9.00-10.01  sec  13.1 MBytes   110 Mbits/sec   80   1.27 MBytes       
[SUM]   9.00-10.01  sec  36.9 MBytes   309 Mbits/sec  313             
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec  23.6 MBytes  19.8 Mbits/sec  893            sender
[  4]   0.00-10.13  sec  23.5 MBytes  19.5 Mbits/sec                  receiver
[  6]   0.00-10.01  sec  82.9 MBytes  69.5 Mbits/sec  158            sender
[  6]   0.00-10.13  sec  81.9 MBytes  67.8 Mbits/sec                  receiver
[  8]   0.00-10.01  sec   120 MBytes   100 Mbits/sec  400            sender
[  8]   0.00-10.13  sec   118 MBytes  98.0 Mbits/sec                  receiver
[ 10]   0.00-10.01  sec   114 MBytes  95.8 Mbits/sec  2087            sender
[ 10]   0.00-10.13  sec   113 MBytes  93.3 Mbits/sec                  receiver
[SUM]   0.00-10.01  sec   340 MBytes   285 Mbits/sec  3538             sender
[SUM]   0.00-10.13  sec   336 MBytes   279 Mbits/sec                  receiver

iperf Done.

=== UDP | 192.168.1.93 ===

Connecting to host 192.168.1.93, port 5201
[  4] local 192.168.1.70 port 60351 connected to 192.168.1.93 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  4]   0.00-1.00   sec  29.9 MBytes   250 Mbits/sec  21618  
[  4]   1.00-2.00   sec  29.8 MBytes   250 Mbits/sec  21561  
[  4]   2.00-3.01   sec  29.9 MBytes   250 Mbits/sec  21674  
[  4]   3.01-4.01   sec  29.8 MBytes   250 Mbits/sec  21581  
[  4]   4.01-5.01   sec  14.1 MBytes   118 Mbits/sec  10183  
[  4]   5.01-6.01   sec  32.0 MBytes   268 Mbits/sec  23178  
[  4]   6.01-7.01   sec  32.8 MBytes   275 Mbits/sec  23772  
[  4]   7.01-8.01   sec  4.02 MBytes  33.8 Mbits/sec  2916  
[  4]   8.01-9.01   sec  22.0 MBytes   185 Mbits/sec  15941  
[  4]   9.01-10.01  sec  24.5 MBytes   206 Mbits/sec  17757  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  4]   0.00-10.01  sec   249 MBytes   209 Mbits/sec  0.000 ms  0/180181 (0%)  sender
[  4]   0.00-10.11  sec   243 MBytes   202 Mbits/sec  0.006 ms  3820/179926 (2.1%)  receiver

iperf Done.
```