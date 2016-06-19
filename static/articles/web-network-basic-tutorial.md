# web 网络基础

正如郭大侠所说，*tcp/ip illustrated*，已经对于计算机网络讲的很细致了，没有必要再“班门弄斧”，但是我不是这样认为的：作为权威书籍，我很认可，但是并不是适用所有的场合，我们需要将计算机网络与web关联的部分集中起来学习，不多也不少，满足需求就好，只要你入了门，后面自己查工具书就好。

# 内容索引

1. [计算机网络简介](#计算机网络简介)
2. [tcp/ip 协议简述](#tcp/ip-协议简述)
3. [python socket通信](#python-socket通信)
4. [http基础](#http基础)
5. [小样](#小样)

# 计算机网络简介

现在使用的计算机网络可以分为两个大层，下三层（物理层，数据链路层，网络层）作为一层，可被称为媒介层，上四层（传输层，会话层，表示层，应用层），可被称为主机层。下三层普遍使用的是以太网协议，上四层使用的TCP/IP协议；上四层与下三层可以使用不同的协议进行组合，下三层主要保证网络结构的构建与管理，数据在结点间的传输，只保证最基本的**比特流**的传输和校验。

<table style="margin: 1em auto 1em auto;">

<tr>
<th colspan="5">OSI 模型</th>
</tr>

<tr>
<th colspan="2">层</th>
<th>协议数据单元</th>
<th style="width:30em;">功能</th>
<th>例子</th>
</tr>

<tr>
<th rowspan="4">主机层</th>
<td style="background:#d8ec9b;">7. 应用层</td>
<td style="background:#d8ec9c;" rowspan="3">数据</td>
<td style="background:#d8ec9c;"><small>High-level APIs, including resource sharing, remote file access</small></td>
<td>DotNetFtpLibrary, SMTP web API, SSH, .NET, SnmpSharpNet, HTML Class, HTTP API server</td>
</tr>

<tr>
<td style="background:#d8ec9b;">6. 表示层</td>
<td style="background:#d8ec9b;"><small>Translation of data between a networking service and an application; including character encoding, data compression and encryption/decryption</small></td>
<td>CSS, GIF, HTML, XML, JSON, S/MIME</td>
</tr>

<tr>
<td style="background:#d8ec9b;">5. 会话层</td>
<td style="background:#d8ec9b;"><small>Managing communication sessions, i.e. continuous exchange of information in the form of multiple back-and-forth transmissions between two nodes</small></td>
<td>RPC, SCP, NFS, PAP, TLS, FTP, HTTP, HTTPS, SMTP, SSH, Telnet</td>
</tr>

<tr>
<td style="background:#e7ed9c;">4. 传输层</td>
<td style="background:#e7ed9c;">TCP/UDP</td>
<td style="background:#e7ed9c;"><small>Reliable transmission of data segments between points on a network, including segmentation, acknowledgement and multiplexing</small></td>
<td>NBF, TCP, UDP</td>
</tr>

<tr>
<th rowspan="3">媒介层</th>
<td style="background:#eddc9c;">3. 网络层</td>
<td style="background:#eddc9c;">数据包</td>
<td style="background:#eddc9c;"><small>Structuring and managing a multi-node network, including addressing, routing and traffic control</small></td>
<td>AppleTalk, ICMP, IPsec, IPv4, IPv6</td>
</tr>

<tr>
<td style="background:#e9c189;">2. 数据链路层</td>
<td style="background:#e9c189;">帧</td>
<td style="background:#e9c189;"><small>Reliable transmission of data frames between two nodes connected by a physical layer</small></td>
<td>IEEE 802.2, L2TP, LLDP, MAC, PPP, ATM, MPLS</td>
</tr>

<tr>
<td style="background:#e9988a;">1. 物理层</td>
<td style="background:#e9988a;">比特</td>
<td style="background:#e9988a;"><small>Transmission and reception of raw bit streams over a physical medium</small></td>
<td>DOCSIS, DSL, Ethernet physical layer, ISDN, RS-232</td>
</tr>

</table>

这里说明举一个很实际的例子：

拿zigbee网络来说吧，IEEE 802.15.4协议是白皮书，而IEEE 802.15.4协议只约定了物理层，数据链路层格式和需要满足的条件，上三层（网络层，ASP层，AF应用层）主要负责应用的开发，上三层协议由zigbee联盟规定的。不同的厂商如德州仪器，飞思卡尔，ATMEL等根据IEEE和zigbee的协议规定，然后结合自己的芯片实现和改进zigbee网络，提供协议栈给用户做应用。

关于为什么网络协议栈会分层：

+ 软件设计分割模块，降低耦合度
+ 合理功能划分，用户根据需求可以以任一层为基础做开发

协议两个相邻的层之间：

+ 上层使用下层提供的接口，使用下层的服务，获取下层确认
+ 下层产生的事件回调交由上层处理

基于RS232的一个简单的区分数据包的协议，详见例子1。


# tcp/ip 协议简述

        #TODO

# python-socket通信

        #TODO

# http基础

        #TODO

# 小样

1. [rs232简单协议](./static/demo/rs232-protocol.md)