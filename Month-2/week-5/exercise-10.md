# Exercise 10

- 193.16.20.35/29<br><br>
What is the Network IP, number of hosts, range of IP addresses and broadcast IP from this subnet?

> **Instruction:**
>
>  Submit all your answer as a markdown file in the folder for this exercise.

<br><br>

---

<br>

### Outline of a progressive breakdown of the subnet

<br>

```
193.16.20.35/29
                        bits                             decimal

IP address  ->  1100001.0001000.0001010.00100011    -> 193.16.20.35

subnet mask ->  1111111.11111111.11111111.11111000  -> 255.255.255.248

Calculating the 0 bits from the subnet mask, helps us identify how many addresses are available in the subnet.

wildcard -> 0.0.0.8

After turning all the bits after the subnet mask to zero, we can then Identify our network address

Network Address -> 193.16.20.32

Broadcast Address -> 193.16.20.39

Host Min. -> 193.16.20.33

Host Max. ->193.16.20.38

This makes a total of 6 available host addresses.
```