-- Note their is better ways for this & is detectable on SOME games that have __namecall detections

hookmetamethod(game, "__namecall", function(self, ...)
    return 
end)
