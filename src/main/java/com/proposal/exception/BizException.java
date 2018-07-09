package com.proposal.exception;

public class BizException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    public BizException(String message) {
        super(message);
    }

    public BizException(Throwable throwable) {
        super(throwable);
    }

    public BizException(String message, Throwable throwable) {
        super(message, throwable);
    }

}
