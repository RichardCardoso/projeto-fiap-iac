#!/bin/bash

NLB_ARN="$1"

status=$(aws elbv2 describe-load-balancers --load-balancer-arns "$NLB_ARN" --query "LoadBalancers[?LoadBalancerArn=='$NLB_ARN'].State.Code" --output text)

while [ "$status" != "active" ]; do
    sleep 10
    status=$(aws elbv2 describe-load-balancers --load-balancer-arns "$NLB_ARN" --query "LoadBalancers[?LoadBalancerArn=='$NLB_ARN'].State.Code" --output text)
done

echo "{ \"status\": \"$status\" }"
