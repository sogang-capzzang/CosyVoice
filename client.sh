#!/bin/bash
function usage(
    {
        echo "Usage: $0 [--host HOST] [--port PORT] [--person PERSON]"
        echo "Options:"
        echo "  --host HOST   Specify the host IP address"
        echo "  --port PORT   Specify the port number for the server (default: 21559)"
        echo "  --person PERSON Specify the person name (default: woon)"
    }
)

usage
PORT=21559
PERSON=woon
while [[ $# -gt 0 ]]; do
    case $1 in
        --port)
            PORT="$2"
            shift 2
            ;;
        --host)
            HOST="$2"
            shift 2
            ;;
        --person)
            PERSON="$2"
            shift 2
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
if [[ -z "$HOST" ]]; then
    echo "Error: Please specify the host IP address using --host option."
    exit 1
fi
python ./runtime/python/fastapi/client.py \
    --host $HOST \
    --port $PORT \
    --person $PERSON \