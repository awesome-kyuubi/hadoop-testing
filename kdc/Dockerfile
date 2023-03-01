# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG PROJECT_VERSION
FROM hadoop-testing/base-ubuntu-2204:$PROJECT_VERSION

# COPY CONFIGURATION
COPY ./files /

# INSTALL KERBEROS
RUN install_packages krb5-kdc krb5-admin-server krb5-user

# CREATE KERBEROS DATABASE
RUN /usr/sbin/kdb5_util create -s -P password

# CREATE ANOTHER KERBEROS DATABASE
RUN mkdir -p /var/lib/krb5kdc && \
    /usr/sbin/kdb5_util create -s -P password -r OTHER.ORG -d /var/lib/krb5kdc/principal-other

# MAKE '.TEST.ORG' TRUST 'OTHER.ORG'
RUN /usr/sbin/kadmin.local -q "addprinc -pw 123456 krbtgt/.TEST.ORG@OTHER.ORG"
RUN /usr/sbin/kadmin.local -q "addprinc -pw 123456 krbtgt/TEST.ORG" -r OTHER.ORG -d /var/lib/krb5kdc/principal-other

# EXPOSE KERBEROS PORTS
EXPOSE	88
EXPOSE	89
EXPOSE	749

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
ENTRYPOINT  ["/opt/entrypoint.sh"]
