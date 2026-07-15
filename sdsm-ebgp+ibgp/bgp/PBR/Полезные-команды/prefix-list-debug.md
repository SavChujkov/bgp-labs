# Информация по префикс-листам



# смотрим наличие prefix-list-ов

- show ip prefix-list
    - вывод что префикс листы существуют и участвуют в двух демонах
    ZEBRA: ip prefix-list BALA-R-OUT: 2 entries
    seq 5 permit 100.0.0.0/24
    seq 10 deny 0.0.0.0/0 ge 32
    ZEBRA: ip prefix-list PHCERT-R-OUT: 2 entries
    seq 5 permit 100.0.0.0/24
    seq 10 deny 0.0.0.0/0 ge 32
    BGP: ip prefix-list BALA-R-OUT: 2 entries
    seq 5 permit 100.0.0.0/24
    seq 10 deny 0.0.0.0/0 ge 32
    BGP: ip prefix-list PHCERT-R-OUT: 2 entries
    seq 5 permit 100.0.0.0/24
    seq 10 deny 0.0.0.0/0 ge 32


# смотрим подробную информацию о prefix листе 

- vtysh -c "show ip prefix-list  detail PHCERT-R-OUT"
    - счетчики например тут самое полезное
    ZEBRA: ip prefix-list PHCERT-R-OUT:
    count: 2, range entries: 0, sequences: 5 - 10
    seq 5 permit 100.0.0.0/24 (hit count: 0, refcount: 0)
    seq 10 deny 0.0.0.0/0 ge 32 (hit count: 0, refcount: 0)
    BGP: ip prefix-list PHCERT-R-OUT:
    count: 2, range entries: 0, sequences: 5 - 10
    seq 5 permit 100.0.0.0/24 (hit count: 1, refcount: 0)
    seq 10 deny 0.0.0.0/0 ge 32 (hit count: 0, refcount: 0)


# смотрим сокращенную инфу о prefix листе
- vtysh -c "show ip prefix-list summary PHCERT-R-OUT"
    - счетчики 
    ZEBRA: ip prefix-list PHCERT-R-OUT:
    count: 2, range entries: 0, sequences: 5 - 10
    BGP: ip prefix-list PHCERT-R-OUT:
    count: 2, range entries: 0, sequences: 5 - 10


# Самая полезная команда - узнаем попадает ли подсеть под prefix-list
- имеем такой префикс лист
    ip prefix-list BALA-R-OUT seq 5 permit 100.0.0.0/24
    ip prefix-list BALA-R-OUT seq 10 deny 0.0.0.0/0 ge 32

- debug prefix-list PHCERT-R-OUT match 100.0.0.0/24
    - сеть permit по этому prefix-list
    IPv4 prefix list PHCERT-R-OUT yields PERMIT for 100.0.0.0/24, matching entry #5: 100.0.0.0/24
    IPv4 prefix list PHCERT-R-OUT yields PERMIT for 100.0.0.0/24, matching entry #5: 100.0.0.0/24

- debug prefix-list PHCERT-R-OUT match 1.1.1.1/32
    - а вот сеть 1.1.1.1 попадает под следующий deny любой сети 0.0.0.0/0
    IPv4 prefix list PHCERT-R-OUT yields DENY for 1.1.1.1/32, matching entry #10: 0.0.0.0/0 ge 32