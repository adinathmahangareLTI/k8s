- use one github repository with java project in it
- add manifests directory with deployment.yaml and service.yaml in it.

  **deployment.yaml**
  ```yaml
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: regapp-deployment
    labels:
       app: regapp
  
  spec:
    replicas: 2
    selector:
      matchLabels:
        app: regapp
  
    template:
      metadata:
        labels:
          app: regapp
      spec:
        containers:
        - name: regapp
          image: 241533119861.dkr.ecr.ap-south-1.amazonaws.com/eksdeployment:latest
          imagePullPolicy: Always
          ports:
          - containerPort: 8080
    strategy:
      type: RollingUpdate
      rollingUpdate:
        maxSurge: 1
        maxUnavailable: 1
  ```

  **service.yaml**
  ```yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: regapp-service
    labels:
      app: regapp
  spec:
    selector:
      app: regapp
  
    ports:
      - port: 8080
        targetPort: 8080
  
    type: LoadBalancer
  ```
  - create one azure virtual machine and create aks cluster on it with nodegroup
      - install azure CLI
      ```
      curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
      ```
      - login in azure account to use azure cli
      ```
      az login
      ```
        using given link and code in output, login in azure
       
      - Create azure kubernetes cluster with node
      ```
      az aks create --resource-group adinath-resource-group --name adinath-cluster-1 --node-count 2 --enable-addons monitoring --generate-ssh-keys
      ```
      - Install kubectl
      ```
      az aks install-cli
      ```
      - Connect to the cluster (get the credentials for your AKS cluster and configure kubectl)
      ```
      az aks get-credentials --resource-group adinath-resource-group --name adinath-cluster-1
      ```
      - Check if nodes are created successfully
      ```
      kubectl get nodes
      ```
      
