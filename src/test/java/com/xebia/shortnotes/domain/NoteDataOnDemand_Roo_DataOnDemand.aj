// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.xebia.shortnotes.domain;

import com.xebia.shortnotes.domain.Note;
import com.xebia.shortnotes.domain.NoteDataOnDemand;
import com.xebia.shortnotes.domain.Notebook;
import com.xebia.shortnotes.domain.NotebookDataOnDemand;
import com.xebia.shortnotes.service.NoteService;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect NoteDataOnDemand_Roo_DataOnDemand {
    
    declare @type: NoteDataOnDemand: @Component;
    
    private Random NoteDataOnDemand.rnd = new SecureRandom();
    
    private List<Note> NoteDataOnDemand.data;
    
    @Autowired
    private NotebookDataOnDemand NoteDataOnDemand.notebookDataOnDemand;
    
    @Autowired
    NoteService NoteDataOnDemand.noteService;
    
    public Note NoteDataOnDemand.getNewTransientNote(int index) {
        Note obj = new Note();
        setContent(obj, index);
        setCreated(obj, index);
        setNotebook(obj, index);
        setTitle(obj, index);
        return obj;
    }
    
    public void NoteDataOnDemand.setContent(Note obj, int index) {
        String content = "content_" + index;
        if (content.length() > 4000) {
            content = content.substring(0, 4000);
        }
        obj.setContent(content);
    }
    
    public void NoteDataOnDemand.setCreated(Note obj, int index) {
        Date created = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setCreated(created);
    }
    
    public void NoteDataOnDemand.setNotebook(Note obj, int index) {
        Notebook notebook = notebookDataOnDemand.getRandomNotebook();
        obj.setNotebook(notebook);
    }
    
    public void NoteDataOnDemand.setTitle(Note obj, int index) {
        String title = "title_" + index;
        obj.setTitle(title);
    }
    
    public Note NoteDataOnDemand.getSpecificNote(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Note obj = data.get(index);
        BigInteger id = obj.getId();
        return noteService.findNote(id);
    }
    
    public Note NoteDataOnDemand.getRandomNote() {
        init();
        Note obj = data.get(rnd.nextInt(data.size()));
        BigInteger id = obj.getId();
        return noteService.findNote(id);
    }
    
    public boolean NoteDataOnDemand.modifyNote(Note obj) {
        return false;
    }
    
    public void NoteDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = noteService.findNoteEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Note' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Note>();
        for (int i = 0; i < 10; i++) {
            Note obj = getNewTransientNote(i);
            try {
                noteService.saveNote(obj);
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            data.add(obj);
        }
    }
    
}