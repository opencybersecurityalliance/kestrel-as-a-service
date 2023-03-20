https://www.keycloak.org/getting-started/getting-started-kube

To check if you have the Ingress addon enabled, enter the following command:

minikube addons list
If the Ingress addon is not enabled, enter the following command to enable it:

minikube addons enable ingress

kubectl create -f https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak.yaml

admin/admin

wget -q -O - https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes-examples/keycloak-ingress.yaml | \
sed "s/KEYCLOAK_HOST/keycloak.$(minikube ip).nip.io/" | \
kubectl create -f -

KEYCLOAK_URL=https://keycloak.$(minikube ip).nip.io &&
echo "" &&
echo "Keycloak:                 $KEYCLOAK_URL" &&
echo "Keycloak Admin Console:   $KEYCLOAK_URL/admin" &&
echo "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account" &&
echo ""

Create a realms - kaas-realm

Create a user - kaas-user

Login with kaas-user

Secure jupyterhub

used master and https://raw.githubusercontent.com/kpeeples/kestrel-as-a-service/main/keycloak/keycloak.yaml

https://keycloak.discourse.group/t/issue-on-userinfo-endpoint-at-keycloak-20/18461/4

https://github.com/bitnami/charts/tree/main/bitnami/keycloak

 helm install my-release --set ingress.enabled=true --set auth.adminUser=admin --set auth.adminPassword=redhat my-repo/keycloak

helm install my-release --set ingress.enabled=true my-repo/keycloak
