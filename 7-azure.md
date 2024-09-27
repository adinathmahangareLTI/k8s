### LAB01: Mounting Azure Container on AWS EC2 instance
1. Create a resource group
2. Create a storage account
3. Create a container
4. Create one amazon EC2 ubuntu instance and run following commands on it
   1. Install microsoft packages:
     - wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
     - dpkg -i packages-microsoft-prod.deb
     - apt-get update

   2. Install blobfuse and libfuse2
     - apt-get install blobfuse
     - apt-get install libfuse2
  
   3. Create temparory mountpoint on ubuntu machine
     - mkdir /mnt/resource/blobfusetmp -p

   4. Create permanent mountpoint on ubuntu machine
     - mkdir ~/mycontainer
  
   5. Create configuration file *fuse-connection.cfg* with below content
     ```bash
      accountName myaccount
      accountKey storageaccesskey
      containerName mycontainer
      authType Key
     ```

   6. Change file permission to 600
     - chmod 600 fuse-connection.cfg
  
   7. Mount container on mount-point using blobfuse
     - blobfuse ~/mycontainer --tmp-path=/mnt/resource/blobfusetmp  --config-file=fuse_connection.cfg
  
--------------------------------------------------------------------------------------------------------------------------------------------------------

   
