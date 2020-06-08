# Forwarding Emails

### AWS CloudFormation Stack, provisions the following set of AWS Services and Code

### Short Description

1. Follow this link to set up Amazon SES to receive inbound emails, and then store those emails:
https://aws.amazon.com/premiumsupport/knowledge-center/ses-receive-inbound-emails/

2. Forwarding Emails to your Inbox Using Amazon SES

	- Create **Lambda Function**
	- Download source code via this link: https://s3.amazonaws.com/blog.bravokeyl.com/aws-ses-forwarder.zip
	- Import **aws-ses-forwarder.zip** to Lambda Function
	- Edit Lambda Function Permission
		```console
		{
		    "Version": "2012-10-17",
		    "Statement": [
		        {
		            "Effect": "Allow",
		            "Action": [
		                "logs:CreateLogGroup",
		                "logs:CreateLogStream",
		                "logs:PutLogEvents"
		            ],
		            "Resource": "arn:aws:logs:*:*:*"
		        },
		        {
		            "Effect": "Allow",
		            "Action": "ses:SendRawEmail",
		            "Resource": "*"
		        },
		        {
		            "Effect": "Allow",
		            "Action": [
		                "s3:GetObject",
		                "s3:PutObject"
		            ],
		            "Resource": "arn:aws:s3:::S3-Bucket-Name/*"
		        }
		    ]
		}
	- Edit lambda Function in **index.js**
		```console
		
		var LambdaForwarder = require("aws-lambda-ses-forwarder");

		exports.handler = function(event, context) {
		  // Configure the S3 bucket and key prefix for stored raw emails, and the
		  // mapping of email addresses to forward from and to.
		  //
		  // Expected keys/values:
		  // - fromEmail: Forwarded emails will come from this verified address
		  // - emailBucket: S3 bucket name where SES stores emails.
		  // - emailKeyPrefix: S3 key name prefix where SES stores email. Include the
		  //   trailing slash.
		  // - forwardMapping: Object where the key is the email address from which to
		  //   forward and the value is an array of email addresses to which to send the
		  //   message.
		  var overrides = {
		    config: {
		      fromEmail: "info@domain.com",
		      subjectPrefix: "",
		      emailBucket: "Bucket-Name",
		      emailKeyPrefix: "",
		      forwardMapping: {
		        "@domain.com": [
		          "name@gmail.com"
		        ]
		      }
		    }
		  };
		  LambdaForwarder.handler(event, context, overrides);
		};

 3. Add Rule Sets on AWS 

	- 	choose **Rule Sets** > choose **View Active Rule Set** > choose **Rule Name**
	-  Add Actioin **Lambda**
	- choose Lambda Function Name that created
	- Save Rule
