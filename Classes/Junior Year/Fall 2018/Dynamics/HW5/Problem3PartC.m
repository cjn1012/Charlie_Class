%Part c

w2 = 4;
w1 = linspace(1,100,100);
mag_accelerations = zeros(100,1);
for i = w1
    accelerations = pointp(i,w2);
    mag_accelerations(i) = norm(accelerations);
end

plot(w1,mag_accelerations)
xlabel('Angular Velocity of the Rod')
ylabel('Magnitude of the Acceleration of P')
title('Angular Velocity of Rod and its Magnitude Acceleration at P')