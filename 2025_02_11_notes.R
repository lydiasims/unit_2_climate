# Lydia Sims Class notes 2025-02-11

#while loops

x=1
while (x<0){
  x=x-1
  print(x) #infinte loop, my worst nightmare
}
x=10
while (x>0){
  x=x-1
  print(x) #well programmed loop
}


#fishing game with while loop
rnorm(n=1, mean=2, sd=1)

n_fish=0
total_catch_lb=0
while(total_catch_lb<50){
  new_fish_weight_lb=rnorm(n=1,mean=5,sd=1)
  n_fish=n_fish+1
  total_catch_lb=total_catch_lb+new_fish_weight_lb
  print(total_catch_lb)
  
}


# arctic sea ice
