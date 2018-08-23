defmodule MyAPIHelper.Ethereum do

  @moduledoc """
  

  """

  def getEthAccount(address) do
    { status, balance_hex } = Ethereumex.HttpClient.eth_get_balance(address)
    balance_hex
    |> String.slice(2..-1)
    |> Hexate.to_integer
  end

  def transferEther(send_public, send_private, to_public, amount) do
    {_,count} = Ethereumex.HttpClient.eth_get_transaction_count(send_public)
    #{_,price} = Ethereumex.HttpClient.eth_gas_price()
    #price |> String.slice(2..-1) |> Hexate.to_integer
    body = Poison.encode!(%{
      "id" => :rand.uniform(999999999999999999999), 
      "method" => Application.get_env(:api, :rpc_call_ts_eth),
      "params" => [%{
        "PrivateKey" => send_private, 
        "PublicKey" => to_public,
        "Amount" => amount, 
        "Nonce" => count |> String.slice(2..-1) |> Hexate.to_integer,
        "GasLimit" => 201000,
        "GasPrice" => 201000
      }]
    })
    {_,res}  = HTTPoison.post Application.get_env(:api, :rpc_url), body, [{"Content-Type", "application/json"}]
    Ethereumex.HttpClient.eth_send_raw_transaction(Poison.decode!(res.body)["result"])
  end

  def contractCall(abi, function, params ,send_public, send_private, to_public, amount) do
    {_,count} = Ethereumex.HttpClient.eth_get_transaction_count(send_public)
    data = abi |> Poison.decode! 
      |> ABI.parse_specification 
      |> Enum.find(&(&1.function == function)) 
      |> ABI.encode(params) 
      |> Base.encode16(case: :lower)
    IO.puts "0x" <> data #Debugging Line
    body = Poison.encode!(%{
      "id" => :rand.uniform(999999999999999999999), 
      "method" => Application.get_env(:api, :rpc_call_contract_eth),
      "params" => [%{
        "PrivateKey" => send_private, 
        "PublicKey" => to_public,
        "Amount" => amount, 
        "Nonce" => count |> String.slice(2..-1) |> Hexate.to_integer,
        "GasLimit" => 201000,
        "GasPrice" => 201000,
        "Data" => "0x" <> data
      }]
    })
    {_,res}  = HTTPoison.post Application.get_env(:api, :rpc_url), body, [{"Content-Type", "application/json"}]
    Ethereumex.HttpClient.eth_send_raw_transaction(Poison.decode!(res.body)["result"])  
  end

  def addressTobinary(string) do
    string |> String.slice(2..-1) |> Hexate.decode
  end

end