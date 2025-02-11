#2025-02-04 boolean and conditional


vec=c(1,0,2,1)
vec
vec[c(FALSE,FALSE,TRUE,T)]
!TRUE
1>2
1>vec
vec>1
vec>=1
c(1,2,3)==c(3,2,1)


1 %in% c(1,2,3)

world_oceans = data.frame(ocean = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                          area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                          avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
world_oceans$avg_depth_m > 4000

sum(world_oceans$avg_depth_m>4000)
world_oceans$ocean[world_oceans$avg_depth_m>4000]

1+2==3
0.1+0.2==0.3
#decimals are not accounted for, very small error

(0.1+0.2)-0.3 #very small answer

error_thres=0.00001
abs(((0.1+0.2)-0.3))>error_thres


x=5
x>3 & x<15

x>3 | x<15
x>3 & x>15
x>3 & x %in% c(1,3,5,7,9)

x>3 & x %in% c(1,3,7,9)

x>3 | x %in% c(1,3,5,7,9)


num=-2
if (num<0){
  num=num*-1
}
num
