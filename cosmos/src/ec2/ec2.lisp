(in-package :aws.cosmos)

#|
  +--------------+
  | EC2-Instance |---------:Tags------------------- Tag
  |              |         (Value)                  (Key)
  |              |
  |              |----:iam-instance-profile-------- Arn
  |              |
  |              |----:block-device-mappings------- EBS ?
  |              |
  |              |----:placement------------------- AvailabilityZone とか
  |              |
  |              |----:network-interfaces---------- ...
  |              |
  |              |----:security-groups------------- ...
  |              |
  |              |----:vpc------------------------- VPC
  |              |
  |              |----:subnet---------------------- SUBNET
  |              |
  |              |----:image----------------------- image
  +--------------+
|#

(defclass ec2-instance (shinrabanshou:shin)
  ((amilaunch-index :accessor amilaunch-index :initarg :amilaunch-index :initform nil)
   (architecture :accessor architecture :initarg :architecture :initform nil)
   (client-token :accessor client-token :initarg :client-token :initform nil)
   (ebs-optimized :accessor ebs-optimized :initarg :ebs-optimized :initform nil)
   (ena-support :accessor ena-support :initarg :ena-support :initform nil)
   (hypervisor :accessor hypervisor :initarg :hypervisor :initform nil)
   (image-id :accessor image-id :initarg :image-id :initform nil)
   (instance-id :accessor instance-id :initarg :instance-id :initform nil)
   (instance-type :accessor instance-type :initarg :instance-type :initform nil)
   (key-name :accessor key-name :initarg :key-name :initform nil)
   (launch-time :accessor launch-time :initarg :launch-time :initform nil)
   (monitoring :accessor monitoring :initarg :monitoring :initform nil)
   (private-dns-name :accessor private-dns-name :initarg :private-dns-name :initform nil)
   (private-ip-address :accessor private-ip-address :initarg :private-ip-address :initform nil)
   (product-codes :accessor product-codes :initarg :product-codes :initform nil)
   (public-dns-name :accessor public-dns-name :initarg :public-dns-name :initform nil)
   (root-device-name :accessor root-device-name :initarg :root-device-name :initform nil)
   (root-device-type :accessor root-device-type :initarg :root-device-type :initform nil)
   (source-dest-check :accessor source-dest-check :initarg :source-dest-check :initform nil)
   (state-transition-reason :accessor state-transition-reason :initarg :state-transition-reason :initform nil)
   (state :accessor state :initarg :state :initform nil)
   (subnet-id :accessor subnet-id :initarg :subnet-id :initform nil)
   (tags :accessor tags :initarg :tags :initform nil)
   (virtualization-type :accessor virtualization-type :initarg :virtualization-type :initform nil)
   (vpc-id :accessor vpc-id :initarg :vpc-id :initform nil)))

(defvar *columns-ec2-instance*
  '((:code :|AmiLaunchIndex|        :slot amilaunch-index         :set-value set-value-simple)
    (:code :|Architecture|          :slot architecture            :set-value set-value-simple)
    (:code :|BlockDeviceMappings|   :slot nil                     :set-value set-value-ignore)
    (:code :|ClientToken|           :slot client-token            :set-value set-value-simple)
    (:code :|EbsOptimized|          :slot ebs-optimized           :set-value set-value-simple)
    (:code :|EnaSupport|            :slot ena-support             :set-value set-value-simple)
    (:code :|Hypervisor|            :slot hypervisor              :set-value set-value-simple)
    (:code :|IamInstanceProfile|    :slot nil                     :set-value set-value-ignore)
    (:code :|ImageId|               :slot image-id                :set-value set-value-simple)
    (:code :|InstanceId|            :slot instance-id             :set-value set-value-simple)
    (:code :|InstanceType|          :slot instance-type           :set-value set-value-simple)
    (:code :|KeyName|               :slot key-name                :set-value set-value-simple)
    (:code :|LaunchTime|            :slot launch-time             :set-value set-value-simple)
    (:code :|Monitoring|            :slot monitoring              :set-value set-value-plist2plist)
    (:code :|NetworkInterfaces|     :slot nil                     :set-value set-value-ignore)
    (:code :|Placement|             :slot nil                     :set-value set-value-ignore)
    (:code :|PrivateDnsName|        :slot private-dns-name        :set-value set-value-simple)
    (:code :|PrivateIpAddress|      :slot private-ip-address      :set-value set-value-simple)
    (:code :|ProductCodes|          :slot product-codes           :set-value set-value-simple)
    (:code :|PublicDnsName|         :slot public-dns-name         :set-value set-value-simple)
    (:code :|RootDeviceName|        :slot root-device-name        :set-value set-value-simple)
    (:code :|RootDeviceType|        :slot root-device-type        :set-value set-value-simple)
    (:code :|SecurityGroups|        :slot nil                     :set-value set-value-ignore)
    (:code :|SourceDestCheck|       :slot source-dest-check       :set-value set-value-simple)
    (:code :|StateTransitionReason| :slot state-transition-reason :set-value set-value-simple)
    (:code :|State|                 :slot state                   :set-value set-value-plist2plist)
    (:code :|SubnetId|              :slot subnet-id               :set-value set-value-simple)
    (:code :|Tags|                  :slot tags                    :set-value set-value-tags2alist)
    (:code :|VirtualizationType|    :slot virtualization-type     :set-value set-value-simple)
    (:code :|VpcId|                 :slot vpc-id                  :set-value set-value-simple)))

(defun %find-ec2-instances (profile)
  (if profile
      (aws :ec2 :describe-instances :--profile profile)
      (aws :ec2 :describe-instances)))

(defun find-ec2-instances (&key profile)
  (let ((results (%find-ec2-instances profile))
        (out nil))
    (dolist (plist (getf results :|Reservations|))
      (dolist (plist-instance (getf plist :|Instances|))
        (push (plist2object 'ec2-instance *columns-ec2-instance* plist-instance)
              out)
        ))
    out))