dnf remove ochami -y
dnf remove openchami -y
systemctl stop openchami.target
sudo systemctl daemon-reload

CORE_CONTAINER="omnia_core"

# Loop through all container names
for CONTAINER in $(podman ps -a --format "{{.Names}}"); do
    if [ "$CONTAINER" != "$CORE_CONTAINER" ]; then
        echo "Deleting container: $CONTAINER"
        podman rm -f "$CONTAINER"
    fi
done

rm -rf /data/oci
rm -rf /data/s3
rm -rf /opt/workdir

echo "Cleanup complete. '$CORE_CONTAINER' preserved."