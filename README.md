# docker-compose_kafka_schema.yaml

This file defines a Docker Compose configuration for setting up a Kafka cluster with Schema Registry, Debezium Connect, Kafka UI, and SQL Server instances.

## Services

*   **kafka1, kafka2, kafka3:** Kafka brokers forming a Kafka cluster.
    *   Image: `confluentinc/cp-kafka:7.9.0`
    *   Environment variables:
        *   `KAFKA_PROCESS_ROLES`: `broker,controller`
        *   `KAFKA_CONTROLLER_LISTENER_NAMES`: `CONTROLLER`
        *   `KAFKA_INTER_BROKER_LISTENER_NAME`: `PLAINTEXT`
        *   `KAFKA_LISTENER_SECURITY_PROTOCOL_MAP`: `CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT`
        *   `CLUSTER_ID`: `ciWo7IWazngRchmPES6q5A==`
        *   `KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR`: 3
        *   `KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS`: 0
        *   `KAFKA_SECURITY_PROTOCOL`: `PLAINTEXT`
        *   `KAFKA_NODE_ID`: 1, 2, 3
        *   `KAFKA_CONTROLLER_QUORUM_VOTERS`: `'1@kafka1:29093,2@kafka2:29094,3@kafka3:29095'`
        *   `KAFKA_ADVERTISED_LISTENERS`: `'PLAINTEXT://kafka1:29092,PLAINTEXT_HOST://localhost:9092'` (for kafka1), etc.
        *   `KAFKA_LISTENERS`: `'CONTROLLER://kafka1:29093,PLAINTEXT://kafka1:29092,PLAINTEXT_HOST://0.0.0.0:9092'` (for kafka1), etc.
    *   Volumes:
        *   `kafka1-data:/var/lib/kafka/data` (for kafka1), etc.
*   **schema-registry:** Schema Registry instance.
    *   Image: `confluentinc/cp-schema-registry:7.9.0`
    *   Environment variables:
        *   `SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS`: `"kafka1:29092,kafka2:29092,kafka3:29092"`
        *   `SCHEMA_REGISTRY_HOST_NAME`: `"schema-registry"`
        *   `SCHEMA_REGISTRY_LISTENERS`: `"http://0.0.0.0:8081"`
*   **zookeeper:** Zookeeper instance.
    *   Image: `confluentinc/cp-zookeeper:latest`
    *   Environment variables:
        *   `ZOOKEEPER_CLIENT_PORT`: `2181`
        *   `ZOOKEEPER_TICK_TIME`: `2000`
*   **kafka-ui:** Kafka UI instance.
    *   Image: `provectuslabs/kafka-ui:latest`
    *   Environment variables:
        *   `KAFKA_CLUSTERS_0_NAME`: `local`
        *   `KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS`: `kafka1:29092,kafka2:29092,kafka3:29092`
        *   `KAFKA_CLUSTERS_0_KAFKACONNECT_0_NAME`: `"connect"`
        *   `KAFKA_CLUSTERS_0_KAFKACONNECT_0_ADDRESS`: `"http://debezium-connect:8083"`
*   **debezium-connect:** Debezium Connect instance.
    *   Image: `debezium/connect:2.4`
    *   Environment variables:
        *   `BOOTSTRAP_SERVERS`: `"kafka1:29092,kafka2:29092,kafka3:29092"`
        *   `GROUP_ID`: `"debezium-group"`
        *   `CONFIG_STORAGE_TOPIC`: `"debezium_connect_configs"`
        *   `OFFSET_STORAGE_TOPIC`: `"debezium_connect_offsets"`
        *   `STATUS_STORAGE_TOPIC`: `"debezium_connect_status"`
        *   `KEY_CONVERTER`: `"org.apache.kafka.connect.json.JsonConverter"`
        *   `VALUE_CONVERTER`: `"org.apache.kafka.connect.json.JsonConverter"`
        *   `CONNECT_REST_ADVERTISED_HOST_NAME`: `"debezium-connect"`
*   **sqlserver-source, sqlserver-destination:** SQL Server instances.
    *   Image: `mcr.microsoft.com/mssql/server:2022-latest`
    *   Environment variables:
        *   `ACCEPT_EULA`: `"Y"`
        *   `SA_PASSWORD`: `"YourStrong@Passw0rd"`
        *   `MSSQL_AGENT_ENABLED`: `"true"`
    *   Volumes:
        *   `sqlserver-source-data:/var/opt/mssql`
        *   `sqlserver-destination-data:/var/opt/mssql`

## Networks

*   **kafka-net:** Bridge network for communication between the services.

## Volumes

*   `kafka1-data`, `kafka2-data`, `kafka3-data`: Volumes for storing Kafka data.
*   `sqlserver-source-data`, `sqlserver-destination-data`: Volumes for storing SQL Server data.
