function [x,U] = FD1d_bvp(N, f, a, b,u)

%*************************************************************80
%% FD1d_bvp �������Ĳ�ָ�ʽ��������ֵ����.
%
%  ����:
%    ���������
%		���� N, ����ڵ���.
%
%    	����f( x ), �����Ҷ˺��� f(x);
%
%    	a, ����������˵�
%
%    	b, ���������Ҷ˵�
%
%		u, ��⺯��
%    ���������
%		��ֽ�����U.

%
%  �����ʷ�����[a,b], �õ�����x(i)=a+(i-1)*(b-a)/(N-1)
%
  h=(b-a)/(N-1);
  x = (a:h:b)'; %(a:h:b)���ص�������������Ҫת��
%
%  �������Բ�ַ�����ϵ������
%

   c1 = -1/h/h;
   c2 = 2/h/h + 1;
   g = [c1*ones(1,N-2), 0];
   c = [0, c1*ones(1,N-2)];
   d = [1, c2*ones(1,N-2), 1];
   A = diag(g, -1)+diag(d)+diag(c,1);
%
%  �������Բ�ַ������Ҷ���
%
  rhs = f(x);
  rhs(1) = u(x(1));
  rhs(N) = u(x(N));
%
%  �����������ϵͳ.
%
  U = A \ rhs;
end
