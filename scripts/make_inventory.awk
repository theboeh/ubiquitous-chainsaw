/instance_a_ip/{
    instance_a_ip = $3
    next
}
/instance_b_ip/{
    instance_b_ip = $3
    next
}
/s3_bucket/{
    s3_bucket = $3
    next
}
END{
   print "[instance_a]"
   print instance_a_ip " ansible_user=ec2-user"
   print ""
   print "[instance_b]"
   print instance_b_ip " ansible_user=ubuntu"
   print ""
   print "[all:vars]"
   print "s3_bucket=" s3_bucket
}
