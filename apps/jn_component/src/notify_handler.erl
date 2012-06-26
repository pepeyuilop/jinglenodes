-module(notify_handler).

-define(NS_CALL_EVENT, 'achievement#event').

-include_lib("exmpp/include/exmpp.hrl").
-include_lib("exmpp/include/exmpp_client.hrl").
-include("../include/jn_component.hrl").
-include_lib("ecomponent/include/ecomponent.hrl").

-export([notify_channel/5]).

notify_channel(ID, {_Node, _, _}, Event, Time, BJID) ->
	?INFO_MSG("Notify Called ~p~n", [BJID]),
	 case BJID of
                undefined ->
                        ok;
		_ ->
        		?INFO_MSG("Broadcast Details: ~p ~p ~p ~p~n", [ID,Event, Time, BJID]),
		        Notify = exmpp_xml:element(?NS_CALL_EVENT, 'query', [],[exmpp_xml:element(undefined, 'event', [exmpp_xml:attribute(<<"key">>, Event), exmpp_xml:attribute(<<"value">>, "1")], [])]),
		        SetBare = exmpp_iq:set(?NS_COMPONENT_ACCEPT, Notify),
                        Broadcast = exmpp_xml:set_attribute(SetBare, <<"to">>, BJID),
			Broadcast
        end;

notify_channel(_, _, _, _, _)-> undefined.

