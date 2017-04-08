function [out] = threshold(in, a, b)
out = ((in < a) | (in > b));