from django.db import models

# Create your models here.

class Instance(models.Model):

    INSTANACE_STATE = [
        ('P','PENDING'),
        ('R','RUNNING'),
        ('S','STOPPED'),
        ('T','TERMINATED')
    ]
    platform_id= models.AutoField(primary_key=True)
    instance_id = models.CharField(max_length=255,blank=False,null=False)
    public_ip = models.CharField(max_length=255,blank=True,default="None")
    private_ip = models.CharField(max_length=255,null=False,default="None")
    instance_state = models.CharField(max_length=255,null=False,default='pending')
    platform = models.CharField(max_length=255,blank=True,default='None')
    platform_state= models.IntegerField(blank=True)
    guacamole_ws_url= models.TextField(blank=True,null=True,default='None')
    guacamole_sharing_url = models.TextField(blank=True,null=True,default='None')
    platform_dns_record = models.TextField(blank=True,null=True,default='None')
    user_name=models.CharField(max_length=255,blank=True,null=True,default="None")
    user_email=models.CharField(max_length=255,blank=True,null=True,default="None")
    user_password=models.CharField(max_length=255,blank=True,null=True,default="None")


    class Meta:
        db_table = "instance"    

    objects = models.Manager()

    def __str__(self):
        return self.instance_id

class AwsEc2Details(models.Model):
    image_id=models.CharField(max_length=255)
    instance_type=models.CharField(max_length=255,default='t2.micro')
    subnet_id = models.CharField(max_length=255,null=False, blank=False)
    security_group_ids = models.CharField(max_length=255)
    iam_profile = models.CharField(max_length=255)
    key_name = models.CharField(max_length=255)
    platform = models.CharField(max_length=255)

    class Meta:
        db_table = "aws_ec2_details"

    objects = models.Manager()

    def __str__(self):
        return self.image_id

class Default_config(models.Model):
    platform = models.CharField(max_length=255,blank=True,default='None')
    version= models.CharField(max_length=200,blank=True)
    framework= models.CharField(max_length=255,blank=True,default="None")
    S3_url= models.TextField(blank=True,null=True,default='None')

    class Meta:
        db_table = "default_config"
    objects = models.Manager()

    def __str__(self):
        return self.version

class Project_details(models.Model):
    git_url = models.CharField(blank=True,null=True,default='None')
    langauge = models.CharField(max_length=200,blank=True,default='None')
    version = models.CharField(max_length=200,blank=True)
    framework = models.CharField(max_length=200,blank=True,default="None")
    git_user = models.CharField(max_length=200,blank=True,default="None")
    git_token = models.CharField(max_length=250,blank=True,default="None")
    git_branch = models.CharField(max_length=200,blank=True,default="None")

    class Meta:
        db_table = "project_details"
    objects = models.Manager()

    def __str__(self):
        return self.version

