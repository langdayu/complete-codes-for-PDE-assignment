function U = FD1d_bvp(N, f, a, b, u)

%*************************************************************80
%% FD1d_bvp �������Ĳ�ָ�ʽ��������ֵ����.
%
%  ����:
%    ���������
%		���� N, ����ڵ���.
%
%    		����f( x ), �����Ҷ˺��� f(x);
%
%    		a, ����������˵�
%
%    		b, ���������Ҷ˵�
%
%		u, ��⺯��
%    ���������
%		��ֽ�����U.

%
%  �����ʷ�����[a,b], �õ�����x(i)=a+(i-1)*(b-a)/(N-1)
%
  h=(b-a)/(N-1);
  x = [a:h:b]';
%
%  �������Բ�ַ�����ϵ������
%
   m = 2/h/h;
   n = -1/h/h;
   d = [1, m*ones(1,N-2), 1];
   g = [n*ones(1,N-2), 0];
   c = [0, n*ones(1,N-2)];
   A = diag(g, -1)+diag(d)+diag(c,1);
%
%  �������Բ�ַ������Ҷ���
%
  rhs = zeros ( N, 1 );  
  rhs = f(x);
  rhs(1) = u(x(1));
  rhs(N) = u(x(N));
%
%  �����������ϵͳ.
%
  U = zeros(N, 1);
  U = A \ rhs;
%
%  ���������ӻ����
%
  ue=zeros(N,1); 
  ue=u(x);

  ee=ue-U;
  e=max(abs(ue-U))
  e0=0;
  e1=0;

  e0 = h*sum(ee.^2);
  
  e1 = sum((ee(2:N)-ee(1:N-1)).^2)/h;

  e1 = e1+e0;
  sqrt(e0)
  sqrt(e1)

  plot(x, ue, '-k*', x, U, 'ro');
  axis([0 1 -1.8 1.8]);
  title('The solution plot');
  xlabel('x');  ylabel('u');
  legend('exact','finite diff');
end

