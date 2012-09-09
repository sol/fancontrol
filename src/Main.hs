module Main (main) where
import           Control.Applicative
import           Control.Monad
import           Control.Concurrent
import           Data.Maybe
import           Data.List

level :: Int -> String
level t
  | t < 53    = "level 0"
  | t < 55    = "level 1"
  | otherwise = "level auto"

main :: IO ()
main = do
  command "watchdog 2"
  forever $ do
    temperature <- readTemperature
    command (level temperature)
    threadDelay dt
  where
    dt = truncate (0.5 * 1e6 :: Double)
    command = writeFile "/proc/acpi/ibm/fan"

-- | Read temperature from all sensors and return the highest value.
readTemperature :: IO Int
readTemperature =
      maximum
    . map read . words
    . fromJust . stripPrefix "temperatures:\t"
  <$> readFile "/proc/acpi/ibm/thermal"
