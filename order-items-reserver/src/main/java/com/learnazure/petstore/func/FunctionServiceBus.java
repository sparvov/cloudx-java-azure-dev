package main.java.com.learnazure.petstore.func;

import com.azure.core.util.BinaryData;
import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;
import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.ServiceBusQueueTrigger;

import java.util.logging.Logger;

/**
 * Azure Functions with HTTP Trigger.
 */
public class FunctionServiceBus {

    private String storageConnectionString;
    private String storageContainer;

    private BlobContainerClient blobContainerClient;
    private Logger logger;

    @FunctionName("ServiceBusOrderItemsReserver")
    public void run(
            @ServiceBusQueueTrigger(name = "msg",
                    queueName = "order-placed-queue",
                    connection = "serviceBusConnectionString"
            ) String message,
            final ExecutionContext context
    ) {
            logger = context.getLogger();
            storageConnectionString = System.getenv("storageConnectionString");
            storageContainer = System.getenv("storageContainer");

            logger.info("Function ServiceBusOrderItemsReserver request message: " + message);

            createBlobContainerClient();

            save(message);
    }

    private void createBlobContainerClient() {
        logger.info("Getting existing BlobContainerClient");

        BlobServiceClient blobServiceClient = new BlobServiceClientBuilder()
                .connectionString(storageConnectionString)
                .buildClient();

        logger.info("Getting existing BlobContainerClient");

        blobContainerClient = blobServiceClient.getBlobContainerClient(storageContainer);
        if (!blobContainerClient.exists()) {
            logger.info("BlobContainerClient does not exist. Creating new BlobContainerClient.");

            blobContainerClient.create();

            logger.info("BlobContainerClient has been successfully created");
        }
    }

    public void save(String payload) {
        BlobClient blobClient = blobContainerClient.getBlobClient(payload);
        blobClient.upload(BinaryData.fromString(payload));

        logger.info("Payload successfully saved to Blob Storage");
    }
}
