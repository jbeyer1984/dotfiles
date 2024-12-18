https://www.reddit.com/r/kde/comments/13e02dl/how_to_fix_the_sleepsuspend_issueglitch_with/?rdt=61877

sudo systemctl enable nvidia-suspend.service

sudo systemctl enable nvidia-hibernate.service

sudo systemctl enable nvidia-resume.service

nvim /lib/modprobe.d/systemd.conf
add
```
options nvidia NVreg_PreserveVideoMemoryAllocations=1
```

sudo dracut-rebuild
