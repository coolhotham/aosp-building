# AOSP Builder
Build aosp project in docker with Ubuntu 20.04 via ci environments (by [Apon77](https://github.com/Apon77))

Thanks [Cirrus CI](https://cirrus-ci.com/) for their awesome service!

I tried to explian every steps by comments! Try to read those throughly!


## Steps:

1. Fork this repo
2. Go to https://github.com/marketplace/cirrus-ci
3. Pricing and setup > Public Repositories > Install it for free
4. In next page click Complete order and begin installation
5. In next page select All repositories or only selected repository (select aosp-builder) > Install
6. In next page give password and Confirm password
7. Setup is done for cirrus ci in your account! You can close the tab now!
8. Install rclone in any pc and setup any cloud drive, where to store cccahe. Setup rclone and collect the content of ~/.config/rclone/rclone.conf and paste that inside cirrus ci repository secret, explained in .cirrus.yml file. You can take help of [rclone website](https://rclone.org) . It's recommended to use own client id and secret, but you can use rclone default config if you can sacrifice some speed (_60MBPS vs 7MBPS upload speed_)! You can use normal google account rather than team drive too! ccache will be fit inside 15GB drive limit hopefully! 
9. Setup google drive index by help of any of these two or any gdrive index you want.

* https://github.com/maple3142/GDIndex \
or,
* https://github.com/Achrou/goindex-theme-acrou

so that it can be accesed url like this https://roms.apon77.workers.dev with a persistance link! Because ccache need to be downloaded everytime you build! You can do your creativity to download ccache or use transfer.sh too! Thats your choice! I use google drive for the speed and not to change ccache url always! Though may be not needed if you can use transfer.sh or other uploading and downoading solutions! But transfer.sh will need to change the ccache url inside downlad_ccache script everytime you push, which is unpleasant! So, rclone is better choice from my perspective.

**I prefer using rclone own id config for google drive team drive with google drive index**
 
10.  All other steps can be found inside every script! Plese read those carefully.
11.  After setting up all other scripts according to your needs, then just do any commit in this repo, and build will be triggered! \
Whenever you need a build you can just commit in this repo. By the way, check the cpu count when you start build, its recommended to use 8cpu and 10cpu for the flexibility (in .cirrus.yml file), Otherwise account gets locks for few times! Which is unpleasant!
12. First commit build should be stopped immediatly with 1cpu, and setup your rclone_config encrypted variable in cirrus ci repo, instructed in .cirrus.yml file
13. Later build should be with 8cpu, also instructed within scripts. 

**Humble request to all not to abuse this system. Happy building!!!**
