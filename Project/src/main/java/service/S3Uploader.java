package service;


import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.PutObjectRequest;

import java.io.File;

public class S3Uploader {

  private final AmazonS3 s3Client;
  private final String bucketName = "my-home-shoppingmall-bucket";

  public S3Uploader() {

    String accessKeyId = System.getenv("AWS_ACCESS_KEY_ID");
    String secretAccessKey = System.getenv("AWS_SECRET_ACCESS_KEY");
    System.out.println(accessKeyId);
    System.out.println(secretAccessKey);



    BasicAWSCredentials awsCreds = new BasicAWSCredentials(accessKeyId, secretAccessKey);
    this.s3Client = AmazonS3ClientBuilder.standard()
        .withRegion("ap-northeast-2")
        .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
        .build();
  }

  public String uploadFile(File file, String fileName) {
    String fileUrl = "https://" + bucketName + ".s3.amazonaws.com/" + fileName;
    s3Client.putObject(new PutObjectRequest(bucketName, fileName, file));

    return fileUrl;
  }
}

