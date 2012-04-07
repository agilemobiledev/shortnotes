package com.xebia.shortnotes.service;

import org.springframework.roo.addon.layers.service.RooService;

import com.xebia.shortnotes.domain.Notebook;

@RooService(domainTypes = { com.xebia.shortnotes.domain.Note.class })
public interface NoteService {

	void updateNotesWithNoteBook(Notebook notebook);

	void removeNotes(Notebook notebook);
}
