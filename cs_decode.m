function [Y]=cosamp(A,G,k)

[m,d]=size(A);

%normalize A
sum_col_A=sum(A.^2);
length_col_A=sqrt(sum_col_A);
norm_A = A ./ repmat(length_col_A, [size(A,1) 1]);
dot_A_r = zeros(size(A,2), 1);

two_k=2*k;
if (two_k > d)
	two_k=d;
end

%declare matrices
[examples, m]=size(G);
Y=[];
max_val=0;
max_j=1;
h=zeros(size(G,2),1);
current_supp=zeros(k,1);
two_k_supp=zeros(two_k,1);
J=zeros(two_k+k, 1);
Aj=zeros(m, two_k+k);
r=h;
w=zeros(two_k+k,1);
y=zeros(d,1);
Y=zeros(examples,d);
unsorted_index=1:1:d;
unsorted_index=unsorted_index';
largest_dots=zeros(d,2);
largest_k=zeros(d,2);
d_minus_k_zeros=zeros(d-k,1);	

for n=1:examples
    h=G(n,:)';
    r=h;

    for i=1:k
        
        %the 2k columns of A most correlated with residual r
        dot_A_r = abs(norm_A'*r);
	largest_dots=[dot_A_r unsorted_index];
	largest_dots=sortrows(largest_dots,-1);
	
	for largest_i=1:two_k
		max_j= largest_dots(largest_i,2);	
        	two_k_supp(largest_i) = max_j;
        end

	%merge support
	J=zeros(two_k+k, 1);
	J(1:two_k,1)=two_k_supp;
	found_supp=0;
	j_index=0;
	j_len=two_k;
	if (i~=1)
		for k_index=1:k
			j_index=1;
			found_supp=0;
			while ((found_supp==0) && (j_index <= two_k))
				if (current_supp(k_index)== J(j_index))
					found_supp=1;
				end
				j_index=j_index+1;
			end
			if (found_supp == 0)
				j_len=j_len+1;
				J(j_len)=current_supp(k_index);
			end
		end
	end
	Aj=zeros(m,two_k+k);
	for a_i=1:j_len
        	Aj(:, a_i) = A(:, J(a_i));
	end

        %least squared restriction to columns in J
        w=pinv(Aj)*h;
               
	y=zeros(d,1);
	for j=1:1:j_len
		y(J(j))=w(j);
	end
	
	%pruning
	largest_k = [abs(y) y unsorted_index];
	largest_k = sortrows(largest_k, 1); %sort in ascending
	largest_k(1:d-k,2)= d_minus_k_zeros; % set everything except the largest k to zero
	current_supp=largest_k(d-k+1:d,3); %record the none zero entries
	largest_k = sortrows(largest_k, 3); %sort to original order
	y=largest_k(:,2);

	%update residual
        r=h-A*y;   
    end
  
    Y(n,:)=y';

end
return
