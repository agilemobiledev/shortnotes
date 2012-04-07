package com.xebia.shortnotes.domain;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.layers.repository.mongo.RooMongoEntity;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooToString
@RooMongoEntity
public class Notebook {

    @NotNull
    private String name;

    @NotNull
    private String author;

    @NotNull
    @Column(updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "M-")
    private Date created = new Date();
}
