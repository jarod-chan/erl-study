-module(func).
-export ([start/0,doSomething/2]).

doSomething(_,0)->
	done;
doSomething(What,Times)->
	io:format("~p~p~n",[What,Times]),
	doSomething(What,Times-1).

start()->
	spawn(tut2,doSomething,[hello,3]),
	spawn(tut2,doSomething,[world,3]).