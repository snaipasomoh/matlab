function Result = stov (str)
	i = 1;
	j = 1;
	res = [];
	while (i <= length(str))
		while (isspace(str(i)))
			i++;
		end
		j = i;
		while (j <= length(str) && !isspace(str(j)))
			j++;
		end
		res = [res, stof(str(i:j-1))];
		i = j;
	end
	Result = res;
end

function Result = stof (str)
	val = 0;
	pow = 0;
	i = 1;
	if (length(str) == 0)
		Result = NaN;
		return;
	end
	if (str(i) == '+')
		numSign = 1;
		i++;
	elseif (str(i) == '-')
		numSign = -1;
		i++;
	else
		numSign = 1;
	end
	while (i <= length(str) && isdigit(str(i)))
		val = val*10 + str(i) - '0';
		i++;
	end
	if (i <= length(str) && str(i) != '.')
		Result = NaN;
		return;
	end
	i++;
	while (i <= length(str) && isdigit(str(i)))
		val = val*10 + str(i) - '0';
		pow--;
		i++;
	end
	if (i <= length(str) && str(i) != 'e' && str(i) != 'E')
		Result = NaN;
		return;
	end
	i++;
	if (i <= length(str) && str(i) == '+')
		expSign = 1;
		i++;
	elseif (i <= length(str) && str(i) == '-')
		expSign = -1;
		i++;
	else
		expSign = 1;
	end
	expVal = 0;
	while (i <= length(str) && isdigit(str(i)))
		expVal = expVal*10 + str(i) - '0';
		i++;
	end
	if (i <= length(str))
		Result = NaN;
		return;
	end
	pow += expSign*expVal;
	Result = numSign*val*power(10, pow);
end