#Crear BuildConfig en Openshift Pipeline
echo "Generate Jenkins"
oc project jenkins
oc create -f BuildConfig.yaml
#Adicionar permisos al service-account del namespace de Jenkins
echo "Add permisos al service del namespaces"
oc policy add-role-to-user edit system:serviceaccount:jenkins:jenkins -n appday-develop
#Crear BuildConfig de tipo binario y referenciando la imagen bade de Java
echo "Create build config"
oc new-build --binary=true --name="apirest-app-day-cicd" openshift/openjdk18-openshift:latest -n appday-develop
echo "Add tag latest image"
oc tag apirest-app-day-cicd apirest-app-day-cicd:latest -n appday-develop
#Crear el DeploymentConfig
echo "Create deploymentConfig"
oc new-app appday-develop/apirest-app-day-cicd:latest --name=apirest-app-day --allow-missing-imagestream-tags=true -n appday-develop
#Desactivar triggers en la app para evitar el build y el deploy  automático (Se quiere que el proceso lo controle jenkins)
echo "Desactivar triggers"
oc set triggers dc/apirest-app-day  --remove-all -n appday-develop
#Crear el service a partir del deploymentConfig, en este caso el puerto 8080
echo "Expose deployment"
oc expose dc apirest-app-day --port 8080 -n appday-develop
echo "Add enviroment"
oc set env dc/apirest-app-day TZ=America/Bogota -n appday-develop
oc set env dc/apirest-app-day JAVA_OPTIONS=-XX:+UseParallelGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Xms100m -Djavax.net.ssl.trustStore=/etc/trustore/truststore.jks -Djavax.net.ssl.trustStorePassword=changeit -n appday-develop
#Crear el route a partir del servicio
echo "Create route"
oc create route edge --service=apirest-app-day -n appday-develop
#Montaje de configmaps y secrets
echo "Montaje configmap"
oc create configmap properties-apirest-app-day --from-file=./src/main/resources/application.properties -n appday-develop
oc set volume dc/apirest-app-day --add --name=properties-apirest-app-day --mount-path=/deployments/config --configmap-name=properties-apirest-app-day -n appday-develop