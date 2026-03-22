alias Learn.Ride
alias Learn.FastPass
{:ok, banana_slip} = Ride.new("banana slip")
{:ok, apple_cart} = Ride.new("apple cart")
{:ok, zebra_coaster} = Ride.new("zebra coaster")

{:ok, fp1} = FastPass.new(banana_slip, ~U[2024-01-01 12:00:00Z])
{:ok, fp2} = FastPass.new(apple_cart, ~U[2024-01-01 13:00:00Z])
{:ok, fp3} = FastPass.new(zebra_coaster, ~U[2024-01-01 11:00:00Z])
