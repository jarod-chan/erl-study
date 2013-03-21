-module (pingpong).
-export([start/0,ping/2,pong/0]).

% 发送固定次数的信息
ping(0,Pong_PID)->
	Pong_PID ! finished,
	io:format("ping finished~n",[]);
ping(N,Pong_PID)->
	Pong_PID ! {ping,self()},
	receive
		pong->
			io:format("ping received from pong~n",[])
	end,
	ping(N-1,Pong_PID).

%pong 接收程序
%根据接收的消息格式打印不同信息
pong()->
	receive 
		finished->
			io:format("pong finished ~n",[]);
		{ping,Ping_PID}->
			io:format("pong received from ping ~p~n",[Ping_PID]),
			Ping_PID ! pong,
			pong()
	end.

start()->
	Pong_PID=spawn(pingpong,pong,[]),
	spawn(pingpong,ping,[10,Pong_PID]).


