
====
Knot
====

Knot DNS is a high-performance authoritative-only DNS server which supports all key features of the modern domain name system.

Sample pillars
==============

Simple server

.. code-block:: yaml

    knot:
      server:
        enabled: true

Server dns templates

.. code-block:: yaml

    knot:
      server:
        enabled: true
        template:
          default:
            storage: /var/lib/knot/master
          signed:
            storage: /var/lib/knot/signed
          slave:
            storage: /var/lib/knot/slave

Server dns zones

.. code-block:: yaml

    knot:
      server:
        enabled: true
        zone:
          example1.com: {}
          example2.com:
            semantic-checks: False
            template: default
            soa:
              email: admin@example1.com
              serial: 20190409001
              master: ns.example2.com
            records:
              - name: mail
                type: A
                content: 192.168.1.1
              - name: '@'
                type: MX
                content: '10 mail'

Read more
=========

* https://www.knot-dns.cz/
