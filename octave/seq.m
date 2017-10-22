function f = seq(varargin)
  for fi=varargin
    if ~isa(fi{1}, 'function_handle')
      error('seq() can only accept function handles for input');
    end
    fi{1}();
  end
end