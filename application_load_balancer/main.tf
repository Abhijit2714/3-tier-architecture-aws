resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet_id_public_2 , var.subnet_id_public_1]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 10
    timeout = 5
    interval = 10
    path = "/"
    port = 80
  }
}


resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = "${aws_lb_target_group.test.arn}"
  target_id        = var.instance 
  port             = 80
}

resource "aws_lb_target_group_attachment" "attachment2" {
  target_group_arn = "${aws_lb_target_group.test.arn}"
  target_id        = var.instance_4
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
