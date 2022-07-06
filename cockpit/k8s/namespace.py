from kubernetes import client
from kubernetes.client import ApiClient
import json
from kubernetes.client.rest import ApiException


def __get_kubernetes_corev1client(bearer_token,api_server_endpoint):
    try:
        #corev1api=("pod","node","config_map","secret","service","namespace","resource")
        configuration = client.Configuration()
        configuration.host = api_server_endpoint
        configuration.verify_ssl = False
        configuration.api_key = {"authorization": "Bearer " + bearer_token}
        client.Configuration.set_default(configuration)
        client_api = client.CoreV1Api()
        return client_api
    except Exception as e:
        print("Error getting kubernetes client \n{}".format(e))
        return None

def __format_data_for_namespace(client_output):
        temp_dict={}
        temp_list=[]
        json_data=ApiClient().sanitize_for_serialization(client_output)
        if len(json_data["items"]) != 0:
            for ns in json_data["items"]:
                temp_dict={
                    "namespace": ns["metadata"]["name"],
                    "status": ns["status"]["phase"]
                }
                temp_list.append(temp_dict)
        return temp_list

def __format_data_for_create_namespace(client_output):
        temp_dict={}
        temp_list=[]
        json_data=ApiClient().sanitize_for_serialization(client_output)
        #print("JSON_DATA OF KUBERNETES OBJECT:{}".format(json_data))
        
        if type(json_data) is str:
            print("FORMAT_DATA :{}".format(type(json_data)))
            json_data = json.loads(json_data)
        temp_list.append(json_data)
        return temp_list
    

def get_namespace(cluster_details):
        client_api= __get_kubernetes_corev1client(
            bearer_token=cluster_details["bearer_token"],
            api_server_endpoint=cluster_details["api_server_endpoint"],
        )
        ns_list = client_api.list_namespace()
        data=__format_data_for_namespace(ns_list)
            # print("Pods under namespaces {}: {}".format(namespace,data))
        return data

def create_namespace(cluster_details, namespace_name):
    # Configs can be set in Configuration class directly or using helper
    # utility. If no argument provided, the config will be loaded from
    # default location.
    try:
        client_api= __get_kubernetes_corev1client(
                bearer_token=cluster_details["bearer_token"],
                api_server_endpoint=cluster_details["api_server_endpoint"],
            )
        body= client.V1Namespace(api_version="v1", kind="Namespace", metadata=client.V1ObjectMeta(name=namespace_name))
        resp = client_api.create_namespace(
            body=body)

        data=__format_data_for_create_namespace(resp)
        return data
    except ApiException as e:
        print("ERROR IN create_ns:\n{}".format(e.body))
        print("TYPE :{}".format(type(e)))
        return __format_data_for_create_namespace(e.body)

# def update_namespace(cluster_details,k8s_object_name=None,yaml_body=None,namespace="default"):
#     # Configs can be set in Configuration class directly or using helper
#     # utility. If no argument provided, the config will be loaded from
#     # default location.
#     try:
#         client_api= __get_kubernetes_corev1client(
#                 bearer_token=cluster_details["bearer_token"],
#                 api_server_endpoint=cluster_details["api_server_endpoint"],
#             )
#         resp = client_api.patch_namespace(
#             name=k8s_object_name,
#             body=yaml_body, 
#             namespace="{}".format(namespace))

#         data=__format_data_for_create_namespace(resp)
#         return data
#     except ApiException as e:
#         print("ERROR IN update_namespace:\n{}".format(e.body))
#         print("TYPE :{}".format(type(e)))
#         return __format_data_for_create_namespace(e.body)

def delete_namespace(cluster_details,k8s_object_name=None,namespace="default"):
    # Configs can be set in Configuration class directly or using helper
    # utility. If no argument provided, the config will be loaded from
    # default location.
    try:
        client_api= __get_kubernetes_corev1client(
                bearer_token=cluster_details["bearer_token"],
                api_server_endpoint=cluster_details["api_server_endpoint"],
            )
        resp = client_api.delete_namespace(
                name=k8s_object_name,
                namespace="{}".format(namespace),
                body=client.V1DeleteOptions(
                    propagation_policy="Foreground", grace_period_seconds=5)
            )

        data=__format_data_for_create_namespace(resp)
        return data
    except ApiException as e:
        print("ERROR IN create_deployment:\n{}".format(e.body))
        print("TYPE :{}".format(type(e)))
        return __format_data_for_create_namespace(e.body)