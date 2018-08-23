package main

import (
	"github.com/gorilla/mux"
	"github.com/gorilla/rpc"
	"github.com/gorilla/rpc/json"
	"log"
	"net/http"
  "bytes"
	"math/big"
  "fmt"
  "github.com/ethereum/go-ethereum/common"
  "github.com/ethereum/go-ethereum/core/types"
  "github.com/ethereum/go-ethereum/crypto"
  "github.com/ethereum/go-ethereum/common/hexutil"
)

type Args struct {
  PrivateKey string
  PublicKey string
  Amount int64
  Nonce int
  GasLimit int
  GasPrice int
}

type ArgContract struct {
  PrivateKey string
  PublicKey string
  Amount int64
  Nonce int
  GasLimit int
  GasPrice int
  Data string
}

type Core int
type Result string

func (t *Core) EthTransfer(r *http.Request, args *Args, result *Result) error {
  privateKey, err := crypto.HexToECDSA(args.PrivateKey)
  if err != nil { log.Fatal(err) }
  value := big.NewInt(args.Amount)
  gasLimit := uint64(args.GasLimit)
  gasPrice := big.NewInt(int64(args.GasLimit))
  toAddress := common.HexToAddress(args.PublicKey)
  var data []byte
  tx := types.NewTransaction(uint64(args.Nonce), toAddress, value, gasLimit, gasPrice, data)
  signedTx, err := types.SignTx(tx, types.HomesteadSigner{}, privateKey)
  if err != nil { log.Fatal(err) }
  var buff bytes.Buffer
  if err := signedTx.EncodeRLP(&buff); err != nil { log.Println("error encode rlp transaction", err) }
  sTx := fmt.Sprintf("0x%x", buff.Bytes())
	*result = Result(sTx)
	return nil
}

func (t *Core) EthContract(r *http.Request, args *ArgContract, result *Result) error {
  privateKey, err := crypto.HexToECDSA(args.PrivateKey)
  if err != nil { log.Fatal(err) }
  value := big.NewInt(args.Amount)
  gasLimit := uint64(args.GasLimit)
  gasPrice := big.NewInt(int64(args.GasLimit))
  toAddress := common.HexToAddress(args.PublicKey)
  data, _ := hexutil.Decode(args.Data)
  tx := types.NewTransaction(uint64(args.Nonce), toAddress, value, gasLimit, gasPrice, data)
  signedTx, err := types.SignTx(tx, types.HomesteadSigner{}, privateKey)
  if err != nil { log.Fatal(err) }
  var buff bytes.Buffer
  if err := signedTx.EncodeRLP(&buff); err != nil { log.Println("error encode rlp transaction", err) }
  sTx := fmt.Sprintf("0x%x", buff.Bytes())
	*result = Result(sTx)
	return nil
}

func main() {
	s := rpc.NewServer()
	s.RegisterCodec(json.NewCodec(), "application/json")
	s.RegisterCodec(json.NewCodec(), "application/json;charset=UTF-8")

	elixir := new(Core)
	s.RegisterService(elixir, "")

	r := mux.NewRouter()
	r.Handle("/rpc", s)
	http.ListenAndServe(":1234", r)
}
