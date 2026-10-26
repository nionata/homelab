
=== TCP Upload (client → server) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 57533 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.01   sec  44.1 MBytes   368 Mbits/sec    0   7.85 MBytes       
[  4]   1.01-2.01   sec  39.4 MBytes   330 Mbits/sec    0   7.85 MBytes       
[  4]   2.01-3.01   sec  44.5 MBytes   373 Mbits/sec    0   7.85 MBytes       
[  4]   3.01-4.00   sec  42.4 MBytes   357 Mbits/sec    0   7.97 MBytes       
[  4]   4.00-5.00   sec  42.6 MBytes   356 Mbits/sec    0   7.97 MBytes       
[  4]   5.00-6.00   sec  41.0 MBytes   345 Mbits/sec    0   7.97 MBytes       
[  4]   6.00-7.00   sec  39.0 MBytes   327 Mbits/sec    0   7.97 MBytes       
[  4]   7.00-8.00   sec  41.9 MBytes   351 Mbits/sec    0   7.97 MBytes       
[  4]   8.00-9.00   sec  10.9 MBytes  91.2 Mbits/sec  2702   91.9 KBytes       
[  4]   9.00-10.01  sec  10.1 MBytes  84.8 Mbits/sec   21    107 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec   356 MBytes   298 Mbits/sec  2723            sender
[  4]   0.00-10.01  sec   356 MBytes   298 Mbits/sec                  receiver

iperf Done.

=== TCP Download (server → client) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
Reverse mode, remote host 192.168.8.219 is sending
[  4] local 192.168.8.141 port 57541 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate
[  4]   0.00-1.00   sec  34.4 MBytes   288 Mbits/sec                  
[  4]   1.00-2.00   sec  35.4 MBytes   297 Mbits/sec                  
[  4]   2.00-3.00   sec  35.6 MBytes   299 Mbits/sec                  
[  4]   3.00-4.01   sec  36.2 MBytes   303 Mbits/sec                  
[  4]   4.01-5.01   sec  38.6 MBytes   324 Mbits/sec                  
[  4]   5.01-6.00   sec  37.0 MBytes   311 Mbits/sec                  
[  4]   6.00-7.00   sec  36.8 MBytes   309 Mbits/sec                  
[  4]   7.00-8.00   sec  37.1 MBytes   311 Mbits/sec                  
[  4]   8.00-9.01   sec  36.2 MBytes   303 Mbits/sec                  
[  4]   9.01-10.01  sec  36.2 MBytes   304 Mbits/sec                  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.01  sec   367 MBytes   308 Mbits/sec   17            sender
[  4]   0.00-10.01  sec   364 MBytes   305 Mbits/sec                  receiver

iperf Done.

=== TCP Multi-stream (4 parallel) | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 57545 connected to 192.168.8.219 port 5201
[  6] local 192.168.8.141 port 57546 connected to 192.168.8.219 port 5201
[  8] local 192.168.8.141 port 57547 connected to 192.168.8.219 port 5201
[ 10] local 192.168.8.141 port 57548 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  4]   0.00-1.00   sec  3.25 MBytes  27.3 Mbits/sec  215   39.6 KBytes       
[  6]   0.00-1.00   sec  7.12 MBytes  59.7 Mbits/sec  197   45.2 KBytes       
[  8]   0.00-1.00   sec  2.88 MBytes  24.1 Mbits/sec   95   65.0 KBytes       
[ 10]   0.00-1.00   sec  2.50 MBytes  21.0 Mbits/sec   82   42.4 KBytes       
[SUM]   0.00-1.00   sec  15.8 MBytes   132 Mbits/sec  589             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   1.00-2.00   sec  4.75 MBytes  39.9 Mbits/sec   78   7.07 KBytes       
[  6]   1.00-2.00   sec  4.62 MBytes  38.8 Mbits/sec   73   12.7 KBytes       
[  8]   1.00-2.00   sec  3.12 MBytes  26.2 Mbits/sec   77   53.7 KBytes       
[ 10]   1.00-2.00   sec  4.62 MBytes  38.8 Mbits/sec   92   50.9 KBytes       
[SUM]   1.00-2.00   sec  17.1 MBytes   144 Mbits/sec  320             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   2.00-3.00   sec  4.50 MBytes  37.7 Mbits/sec   54   73.5 KBytes       
[  6]   2.00-3.00   sec  4.88 MBytes  40.8 Mbits/sec   97   17.0 KBytes       
[  8]   2.00-3.00   sec  5.38 MBytes  45.0 Mbits/sec  116   35.4 KBytes       
[ 10]   2.00-3.00   sec  5.38 MBytes  45.0 Mbits/sec  104   73.5 KBytes       
[SUM]   2.00-3.00   sec  20.1 MBytes   168 Mbits/sec  371             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   3.00-4.00   sec  3.62 MBytes  30.4 Mbits/sec   81   50.9 KBytes       
[  6]   3.00-4.00   sec  6.50 MBytes  54.6 Mbits/sec   71   45.2 KBytes       
[  8]   3.00-4.00   sec  2.12 MBytes  17.8 Mbits/sec  121   32.5 KBytes       
[ 10]   3.00-4.00   sec  7.12 MBytes  59.8 Mbits/sec   70   52.3 KBytes       
[SUM]   3.00-4.00   sec  19.4 MBytes   163 Mbits/sec  343             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   4.00-5.00   sec  4.88 MBytes  40.9 Mbits/sec  130   45.2 KBytes       
[  6]   4.00-5.00   sec  4.50 MBytes  37.7 Mbits/sec  114   33.9 KBytes       
[  8]   4.00-5.00   sec  4.88 MBytes  40.9 Mbits/sec   62   35.4 KBytes       
[ 10]   4.00-5.00   sec  4.50 MBytes  37.7 Mbits/sec  116   46.7 KBytes       
[SUM]   4.00-5.00   sec  18.8 MBytes   157 Mbits/sec  422             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   5.00-6.00   sec  6.00 MBytes  50.3 Mbits/sec   69   38.2 KBytes       
[  6]   5.00-6.00   sec  4.12 MBytes  34.6 Mbits/sec   71   15.6 KBytes       
[  8]   5.00-6.00   sec  6.75 MBytes  56.6 Mbits/sec   71   66.5 KBytes       
[ 10]   5.00-6.00   sec  2.62 MBytes  22.0 Mbits/sec  117   39.6 KBytes       
[SUM]   5.00-6.00   sec  19.5 MBytes   164 Mbits/sec  328             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   6.00-7.01   sec  4.62 MBytes  38.7 Mbits/sec  118   55.1 KBytes       
[  6]   6.00-7.01   sec  5.00 MBytes  41.8 Mbits/sec   85   66.5 KBytes       
[  8]   6.00-7.01   sec  6.88 MBytes  57.5 Mbits/sec  126   26.9 KBytes       
[ 10]   6.00-7.01   sec  3.75 MBytes  31.4 Mbits/sec  104   32.5 KBytes       
[SUM]   6.00-7.01   sec  20.2 MBytes   169 Mbits/sec  433             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   7.01-8.00   sec  6.38 MBytes  53.7 Mbits/sec   74   66.5 KBytes       
[  6]   7.01-8.00   sec  5.12 MBytes  43.2 Mbits/sec  128   38.2 KBytes       
[  8]   7.01-8.00   sec  4.50 MBytes  37.9 Mbits/sec  138   43.8 KBytes       
[ 10]   7.01-8.00   sec  3.62 MBytes  30.5 Mbits/sec   89   35.4 KBytes       
[SUM]   7.01-8.00   sec  19.6 MBytes   165 Mbits/sec  429             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   8.00-9.00   sec  5.25 MBytes  43.9 Mbits/sec   71   60.8 KBytes       
[  6]   8.00-9.00   sec  4.38 MBytes  36.6 Mbits/sec  124   33.9 KBytes       
[  8]   8.00-9.00   sec  4.62 MBytes  38.7 Mbits/sec   72   25.5 KBytes       
[ 10]   8.00-9.00   sec  3.00 MBytes  25.1 Mbits/sec  108   43.8 KBytes       
[SUM]   8.00-9.00   sec  17.2 MBytes   144 Mbits/sec  375             
- - - - - - - - - - - - - - - - - - - - - - - - -
[  4]   9.00-10.00  sec  4.88 MBytes  41.0 Mbits/sec  110   45.2 KBytes       
[  6]   9.00-10.00  sec  4.75 MBytes  40.0 Mbits/sec   36   46.7 KBytes       
[  8]   9.00-10.00  sec  2.75 MBytes  23.1 Mbits/sec  104   35.4 KBytes       
[ 10]   9.00-10.00  sec  3.50 MBytes  29.4 Mbits/sec   74   46.7 KBytes       
[SUM]   9.00-10.00  sec  15.9 MBytes   134 Mbits/sec  324             
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  4]   0.00-10.00  sec  48.1 MBytes  40.4 Mbits/sec  1000            sender
[  4]   0.00-10.01  sec  48.0 MBytes  40.2 Mbits/sec                  receiver
[  6]   0.00-10.00  sec  51.0 MBytes  42.8 Mbits/sec  996            sender
[  6]   0.00-10.01  sec  50.9 MBytes  42.6 Mbits/sec                  receiver
[  8]   0.00-10.00  sec  43.9 MBytes  36.8 Mbits/sec  982            sender
[  8]   0.00-10.01  sec  43.8 MBytes  36.7 Mbits/sec                  receiver
[ 10]   0.00-10.00  sec  40.6 MBytes  34.1 Mbits/sec  956            sender
[ 10]   0.00-10.01  sec  40.5 MBytes  34.0 Mbits/sec                  receiver
[SUM]   0.00-10.00  sec   184 MBytes   154 Mbits/sec  3934             sender
[SUM]   0.00-10.01  sec   183 MBytes   154 Mbits/sec                  receiver

iperf Done.

=== UDP | 192.168.8.219 ===

Connecting to host 192.168.8.219, port 5201
[  4] local 192.168.8.141 port 64946 connected to 192.168.8.219 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  4]   0.00-1.00   sec  29.9 MBytes   250 Mbits/sec  21681  
[  4]   1.00-2.00   sec  29.7 MBytes   250 Mbits/sec  21507  
[  4]   2.00-3.00   sec  29.8 MBytes   250 Mbits/sec  21561  
[  4]   3.00-4.00   sec  29.8 MBytes   250 Mbits/sec  21586  
[  4]   4.00-5.00   sec  29.8 MBytes   250 Mbits/sec  21606  
[  4]   5.00-6.00   sec  29.8 MBytes   250 Mbits/sec  21567  
[  4]   6.00-7.00   sec  29.8 MBytes   250 Mbits/sec  21572  
[  4]   7.00-8.01   sec  29.9 MBytes   250 Mbits/sec  21680  
[  4]   8.01-9.00   sec  29.7 MBytes   250 Mbits/sec  21475  
[  4]   9.00-10.00  sec  29.8 MBytes   250 Mbits/sec  21596  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  4]   0.00-10.00  sec   298 MBytes   250 Mbits/sec  0.000 ms  0/215831 (0%)  sender
[  4]   0.00-10.07  sec   261 MBytes   217 Mbits/sec  0.069 ms  26983/215831 (13%)  receiver

iperf Done.
