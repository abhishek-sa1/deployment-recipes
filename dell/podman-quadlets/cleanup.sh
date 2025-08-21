dnf remove ochami -y
dnf remove openchami -y
systemctl stop openchami.target
rm -rf /etc/containers/systemd/registry.container
rm -rf /etc/containers/systemd/minio.container
sudo systemctl daemon-reload

CORE_CONTAINER="omnia_core"

podman rm minio-server \
          registry \
          step-ca \
          postgres \
          hydra \
          opaal-idp \
          smd \
          bss \
          opaal \
          cloud-init-server \
          haproxy \
          coresmd -f

podman volume rm haproxy-certs \
                 acme-certs \
                 postgres-data \
                 step-ca-db \
                 step-root-ca \
                 step-ca-home -f 

podman secret rm hydra_postgres_password \
                 hydra_dsn \
                 hydra_system_secret \
                 smd_postgres_password \
                 postgres_password \
                 postgres_multiple_databases \
                 bss_postgres_password -f

rm -rf /data/oci
rm -rf /data/s3
rm -rf /opt/workdir
rm -rf /etc/ochami/configs/coredhcp.yaml

echo "Cleanup complete. '$CORE_CONTAINER' preserved."