function [ARR, IND] = mSort (array)
	len = length(array);
	ind = [1:len];
	for j = [1:len - 1]
		for i = [1:len - j]
			if (array(i) > array(i + 1))
				t = array(i);
				array(i) = array(i + 1);
				array(i + 1) = t;
				t = ind(i);
				ind(i) = ind(i + 1);
				ind(i + 1) = t;
			end
		end
	end
	ARR = array;
	IND = ind;
end