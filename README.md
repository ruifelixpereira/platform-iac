# Platform Landing Zone

The main purpose of this repository is to provide a Platform landing zone including the following component sets:

1. **Networking**
    - [x] Virtual WAN
    - [x] Virtual Hub with ER Gateway and Firewall

2. **Firewall Rules**
    - [x] Firewall Policy
    - [x] Firewall Policy Rules Collection Group

3. **Management**
    - [x] Log Analytics Workspace


## Contents

| Platform LZ Component Set        | Folder     |
|--------------------------------- |------------|
| Granular Modules                 | modules    |
| Landing Zones that use modules   | lz         |


## Testing

In order to test the code you can use the provided test script in each of these component sets:

```bash
# Choose the component set to test (e.g., Foundation LZ)
cd lz/foundation-lz

# Customize you environment settings by creating a file .env and editing the environment variables
cp .env.sample .env
# Edit your environment variables in .env

# Test the deployment
./test.sh
```

## References
- [Azure Landing Zones Accelerator](https://azure.github.io/Azure-Landing-Zones/accelerator/)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [AKS Landing Zone Accelerator](https://github.com/Azure/AKS-Landing-Zone-Accelerator)
