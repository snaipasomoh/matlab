function [Quotient, Modulo] = divPolinom (divident, divisor)
	divident = cutPolinom(divident);
	divisor = cutPolinom(divisor);
	
	Quotient = zeros(1, length(divident));
	while length(divident) >= length(divisor)
		tempMult = divident(length(divident))/divisor(length(divisor));
		tempDegr = length(divident) - length(divisor);
		Quotient(tempDegr+1) = tempMult;
		tempPol = multPolinom(divisor, tempMult, tempDegr);
		divident -= tempPol;
		divident = cutPolinom(divident);
	end
	Quotient = cutPolinom(Quotient);
	Modulo = divident;
end

function Result = cutPolinom (polinom)
	for i = [length(polinom):-1:1]
		if polinom(i)
			polinom = polinom(1:i);
			break;
		end
		if i == 1
			polinom = 0;
		end
	end
	Result = polinom;
end

function Result = multPolinom (polinom, multiplier, degree)
	polinom *= multiplier;
	polinom = [zeros(1, degree), polinom];
	Result = cutPolinom(polinom);
end