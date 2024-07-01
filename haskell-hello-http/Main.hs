module Main where

import Network.HTTP.Simple

main :: IO ()
main = do
  request <- parseRequest "http://httpbin.org/ip"
  response <- httpLBS request
  putStrLn "The status code was:"
  print $ getResponseStatusCode response
  putStrLn "The response body was:"
  print $ getResponseBody response
