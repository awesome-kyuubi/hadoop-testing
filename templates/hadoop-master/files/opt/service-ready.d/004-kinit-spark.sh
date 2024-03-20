#!/usr/bin/env bash

{% if kerberos_enabled %}
kinit -kt /share/keytabs/hadoop-master1/spark.service.keytab spark/hadoop-master1.orb.local@TEST.ORG
{% endif %}
