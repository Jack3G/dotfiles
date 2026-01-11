youtube-dl -g https://www.youtube.com/watch?v=4bPj8jZCo1A&list=PLjOiSuJzf3V2JIA6Lgp4XrGm-XQ3oF9wz&index=5 -f 140 | lines | each { | aa | mpc add $aa }
